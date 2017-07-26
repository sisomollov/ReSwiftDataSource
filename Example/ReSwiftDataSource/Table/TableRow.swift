
import Foundation
import ReSwiftDataSource

struct TableRow: Item, Equatable {
    var text: String
    var viewClass: AnyClass? = TBCell.self

    // MARK: - Init
    init(text: String) {
        self.text = text
    }

    // MARK: - Equatable
    static func ==(lhs: TableRow, rhs: TableRow) -> Bool {
        return lhs.text == rhs.text
    }
}
