
import Foundation
import ReSwiftDataSource

class TestRow: TableRow, Equatable {
    var identifier: String = UUID().uuidString
    var message: String
    var cellClass: AnyClass

    init(message: String, cellClass: AnyClass) {
        self.message = message
        self.cellClass = cellClass
    }


    // MARK: - Equatable
    static func ==(lhs: TestRow, rhs: TestRow) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
