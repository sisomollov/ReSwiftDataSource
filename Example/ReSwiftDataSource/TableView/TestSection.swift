
import Foundation
import ReSwiftDataSource

struct TestSection: TableSection, Equatable {

    var title: String = "Section Title"
    var identifier: String = UUID().uuidString
    var rows: [TableRow] = []

    static func ==(lhs: TestSection, rhs: TestSection) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
