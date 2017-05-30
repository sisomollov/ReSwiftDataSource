
import UIKit
import ReSwiftDataSource

final class TestCell: UITableViewCell, TableCell {

    var row: TestRow?

    func apply(row: TableRow) {
        guard let row = row as? TestRow else { return }

        textLabel?.text = row.message

        self.row = row
    }
}
