
import UIKit
import ReSwiftDataSource

final class TableVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private(set) var wrapper: Wrapper!

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        wrapper = Wrapper(tableView: tableView)

        let cell = Describer(viewClass: TBCell.self)
        let header = Describer(viewClass: TableHeader.self, context: .header)
        tableView.append(cell)
        tableView.append(header)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe( wrapper ) { $0.select { state in state.tableState } }

        guard var section = wrapper.section(index: 0) else { return }

        let item1 = TableRow(text: "Test message 1")
        let item2 = TableRow(text: "Test message 2")
        section.items.append(item1)
        section.items.append(item2)

        store.dispatch( TableAction.updateItems(section.items, in: 0) )
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        store.unsubscribe( wrapper )
    }
}
