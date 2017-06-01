
import UIKit
import ReSwiftDataSource
import ReSwift

final class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var wrapper: Wrapper?

    let printer1 = TablePrinter()
    let printer2 = Table2Printer()

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wrapper = Wrapper(tableView: tableView)
        let describer = TableCellDescriber(cellClass: TestCell.self)
        tableView.append(layout: describer)

        var rows = [TestRow]()
        rows.append(TestRow(message: "Row1", cellClass: TestCell.self))
        rows.append(TestRow(message: "Row2", cellClass: TestCell.self))
        rows.append(TestRow(message: "Row3", cellClass: TestCell.self))
        rows.append(TestRow(message: "Row4", cellClass: TestCell.self))
        rows.append(TestRow(message: "Row5", cellClass: TestCell.self))

        let action = TestTableAction.updateRows(rows, in: 0)
        store.dispatch(action)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let wrapper = wrapper else { return }

        store.subscribe(wrapper) { $0.select { state in state.tableState } }
        store.subscribe(printer1) { $0.select { state in state.tableState } }
        store.subscribe(printer2) { $0.select { state in state.table2State } }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        guard let wrapper = wrapper else { return }
        store.unsubscribe(wrapper)
        store.unsubscribe(printer1)
        store.unsubscribe(printer2)
    }

    @IBAction func addRows(_ sender: UIBarButtonItem) {
        var rows = wrapper!.state.data[0].rows
        rows.append(TestRow(message: "Test Row", cellClass: TestCell.self))
        rows.append(TestRow(message: "Test Row", cellClass: TestCell.self))

        let action = TestTableAction.updateRows(rows, in: 0)
        store.dispatch(action)
    }
    @IBAction func deleteRow(_ sender: UIBarButtonItem) {
        var rows = wrapper!.state.data[0].rows
        rows.removeLast()

        let action = TestTableAction.updateRows(rows, in: 0)
        store.dispatch(action)
    }

    @IBAction func reset(_ sender: UIBarButtonItem) {
        let section = TestSection()
        let action = TestTableAction.reset(section: section)

        store.dispatch(action)
    }

    final class Wrapper: TableWrapper<TestSection, TestRow, TestTableState>, UITableViewDelegate {

        override init(tableView: UITableView) {
            super.init(tableView: tableView)

            tableView.delegate = self
        }

        @nonobjc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            guard let section = state.data[section] as? TestSection else { return nil }
            return section.title
        }

        func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
            print("Highlight")
        }
    }
}

// MARK: - Printers

class TablePrinter: StoreSubscriber {
    typealias StoreSubscriberStateType = TestTableState

    func newState(state: TestTableState) {
        print("Table 1: \(state)")
    }
}

class Table2Printer: StoreSubscriber {
    typealias StoreSubscriberStateType = TestTableState

    func newState(state: TestTableState) {
        print("Table 2: \(state)")
    }
}

