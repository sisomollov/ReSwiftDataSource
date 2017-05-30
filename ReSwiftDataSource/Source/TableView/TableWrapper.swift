
import UIKit
import ReSwift
import Changeset

open class TableWrapper<S, R, State: TableState>: NSObject, StoreSubscriber,
    UITableViewDataSource, UITableViewDelegate
where S: TableSection & Equatable, R: TableRow & Equatable {

    // MARK: - Properties

    public var tableView: UITableView?
    public var state: State = State()

    // MARK: - Init

    public init(tableView: UITableView) {
        super.init()

        self.tableView             = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate   = self
    }

    // MARK: - Perform Updates
    func performUpdates(state: State) {
        var sourceState = self.state

        switch state.operation {
        case .updateRows(let section):
            guard let sourceRows = sourceState.data[section].rows as? [R] else { return }
            guard let targetRows = state.data[section].rows as? [R] else { return }
            let edits = Changeset.edits(from: sourceRows, to: targetRows)

            self.state = state
            tableView?.update(with: edits, in: section)
        case .updateSections, .reset:
            guard let sourceSections = sourceState.data as? [S] else { return }
            guard let targetSections = state.data as? [S] else { return }
            let edits = Changeset.edits(from: sourceSections, to: targetSections)

            guard !edits.isEmpty else { return }

            let (insertions, deletions, updates) = batchIndexSets(from: edits)

            self.state = state
            tableView?.beginUpdates()

            if !deletions.isEmpty { tableView?.deleteSections(deletions, with: .automatic) }
            if !insertions.isEmpty { tableView?.insertSections(insertions, with: .automatic) }
            if !updates.isEmpty { tableView?.reloadSections(updates, with: .automatic) }

            tableView?.endUpdates()

        default: break
        }
    }

    private func batchIndexSets<T: Equatable>(from edits: [Edit<T>])
        -> (insertions: IndexSet, deletions: IndexSet, updates: IndexSet) {

            var insertions = IndexSet()
            var deletions = IndexSet()
            var updates = IndexSet()
            for edit in edits {
                let index = edit.destination

                switch edit.operation {
                case .deletion:
                    deletions.insert(index)
                case .insertion:
                    insertions.insert(index)
                case .move(let origin):
                    deletions.insert(origin)
                    insertions.insert(index)
                case .substitution:
                    updates.insert(index)
                }
            }

            return (insertions, deletions, updates)
    }

    // MARK: - DataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        assert(state.data.count > 0, "TableState.data must have at least one section")

        return state.data.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = state.data[section].rows.count

        return number
    }

    public
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = state.data[indexPath.section]

        let row = section.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath)

        if let cell = cell as? TableCell {
            cell.apply(row: row)
        }

        return cell
    }
    
}

// MARK: - StoreSubscriber
extension TableWrapper {
    public typealias StoreSubscriberStateType = State
    
    public func newState(state: State) {
        performUpdates(state: state)
    }
}
