
import Foundation
import ReSwiftDataSource

struct TestTableState: TableState {
    var identifier                     = UUID().uuidString
    var data: [TableSection]           = [TestSection()]
    var operation: TableStateOperation = .none
}

extension TestTableState: Equatable {
    static func ==(lhs: TestTableState, rhs: TestTableState) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}


