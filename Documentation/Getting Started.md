# Usage

##### Cells (ReusableViews):
First you have to create the cells, headers and footers classes. No matter **UITableViews** or **UICollectionViews** they conforms to the *ReusableView* protocol.
***

##### Items:
Every **ReusableView** has a *Item* that corresponds to it. Items holds all of the data that every ReusableView has to present.

Example:
```swift
// Every Item must be Equatable too.
struct TableItem: Item, Equatable {
    var text: String
    var viewClass: AnyClass? = TableCell.self

    static func ==(lhs: TableItem, rhs: TableItem) -> Bool {
        return lhs.text == rhs.text
    }
}

final class TableCell: UITableViewCell, ReusableView {
    var rowItem: TableRow? {
        didSet { textLabel?.text = rowItem?.text }
    }
    func apply(item: Item) {
        if let row = item as? TableRow { rowItem = row }
    }
}
```
- use same technique for the custom **headers** and **footers**
***

##### Sections
After we were created the ReusableViews and their Items. We need to put these items into item sections.
To create item sections we are going to use **ItemSection** and Equatable protocols.

Example:
```swift
struct TableSection: ItemSection, Equatable {
    var items: [Item] = []

    var headerTitle: String?
    var footerTitle: String?

    var headerItem: Item?
    var footerItem: Item?

    // MARK: - Init
    init(title: String) {
        self.title = title
    }

    // MARK: - Equatable
    ...
}
```
To use default sections and footers in **UITableViews** use:
```swift
var headerTitle: String?
var footerTitle: String?
```
for custom ones and for sections and footers in **UICollectionViews** use:
```swift
var headerItem: Item?
var footerItem: Item?
```
***

##### State
After reusable views, items and item sections has been created.
Both **UITableViews** and **UICollectionViews** has to have a state, that conforms to *DataSourceState*.

It's a good thing if the state also conforms to Equatable protocol to lower refreshing attempts.

Example:
```swift
struct TableState: DataSourceState {
    var operation: DataSourceStateOperation = .none
    var data: [ItemSection] = [TableSection(title: "Section 1")]
}
```
***
##### Actions
Example:
```swift
struct TableAction: DataSourceAction {
    var operation: DataSourceStateOperation
    var sections: [ItemSection]?
    var items: [Item]?

    init(operation: DataSourceStateOperation) {
       self.operation = operation
    }
}
```
***
##### Reducer
Example:
```swift
//... in state reducer
state.tableState = DataSourceReducer<TableState, TableAction>
    .reducer(action: action, state: state.tableState)
// ...
return state
```
***
##### VC
Example:
```swift
// .. in ViewContreller
@IBOutlet weak var tableView: UITableView!
var wrapper: Wrapper!

// MARK: - Override
override func viewDidLoad() {
    super.viewDidLoad()

    wrapper = Wrapper(tableView: tableView)

    let cell = Describer(viewClass: TableCell.self)
    tableView.append(cell)

    // to register headers and footers
    let header = Describer(viewClass: TableHeader.self, context: .header)
    tableView.append(header)
}
```
***
##### Wrapper

Example:
```swift
final class Wrapper: TableWrapper<TableSection, TableItem, TableState>, UITableViewDelegate {
    // MARK: - Override
    override init(tableView: UITableView) {
       super.init(tableView: tableView)

       tableView.delegate = self
    }

    // MARK: - Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let headerItem = self.section(index: section)?.headerItem else { return nil }
       return reusableView(item: headerItem)
    }
}
```
***

##### Add/Edit
Example:
```swift
var section = wrapper.section(index: 0)

let item1 = TableItem(text: "Test message 1")
let item2 = TableItem(text: "Test message 2")
section.items.append(item1)
section.items.append(item2)

store.dispatch( TableAction.updateItems(section.items, in: 0) )
```
