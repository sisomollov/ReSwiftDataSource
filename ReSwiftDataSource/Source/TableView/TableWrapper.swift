
import UIKit
import ReSwift
import Changeset

open class TableWrapper<Section, Rows, State>: NSObject, StoreSubscriber, UITableViewDataSource
where Section: ItemSection & Equatable, Rows: Item & Equatable, State: DataSourceState {

    // MARK: - Properties
    public var tableView: UITableView?
    public var state: State = State()

    // MARK: - Init
    public init(tableView: UITableView) {
        super.init()

        self.tableView             = tableView
        self.tableView?.dataSource = self
    }

    // MARK: - Perform Updates
    func performUpdates(state: State) {
        var sourceState = self.state

        switch state.operation.value {
        case .updateItems(let section):
            guard let sourceRows = sourceState.data[section].items as? [Rows] else { return }
            guard let targetRows = state.data[section].items as? [Rows] else { return }
            let edits = Changeset.edits(from: sourceRows, to: targetRows)

            self.state = state
            tableView?.update(with: edits, in: section)
        case .updateSections, .reset:
            guard let sourceSections = sourceState.data as? [Section] else { return }
            guard let targetSections = state.data as? [Section] else { return }
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

    // MARK: - DataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        assert(state.data.count > 0, "TableState.data must have at least one section")

        return state.data.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = state.data[section].items.count

        return number
    }
    public
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = state.data[indexPath.section]
        let row = section.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath)
        if let cell = cell as? ReusableView {
            cell.apply(item: row)
        }

        return cell
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
        let section = self.section(index: section)
        return section?.headerItem != nil ? nil: section?.headerTitle
    }
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int)
        -> String? {
        let section = self.section(index: section)
        return section?.footerItem != nil ? nil: section?.footerTitle
    }

    // MARK: - Public API
    public func reusableView(item: Item) -> UIView? {
        let reusableView = tableView?.dequeueReusableHeaderFooterView(withIdentifier: item.reuseId)
        if let reusableView = reusableView as? ReusableView {
            reusableView.apply(item: item)
        }

        return reusableView
    }
    public func section(index: Int) -> Section? {
        if let section = state.data[index] as? Section {
            return section
        }
        return nil
    }
}

// MARK: - StoreSubscriber
extension TableWrapper {
    public typealias StoreSubscriberStateType = State
    
    public func newState(state: State) {
        performUpdates(state: state)
    }
}
