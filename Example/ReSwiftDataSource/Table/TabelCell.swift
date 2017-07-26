
import UIKit
import ReSwiftDataSource


final class TBCell: UITableViewCell, ReusableView {

    var rowItem: TableRow? {
        didSet {
            textLabel?.text = rowItem?.text
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        rowItem = nil
        textLabel?.text = ""
    }

    func apply(item: Item) {
        if let row = item as? TableRow {
            rowItem = row
        }
    }
}
