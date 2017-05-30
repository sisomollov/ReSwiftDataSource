
import Foundation
import ReSwiftDataSource
import ReSwift

// Test
struct TestTableAction: TableAction {
    var operation: TableStateOperation
    var sections: [TableSection]?
    var rowsUpdate: (rows: [TableRow], section: Int)?

    init(operation: TableStateOperation) {
        self.operation = operation
    }
}


struct Test2TableAction: TableAction {
    var operation: TableStateOperation
    var sections: [TableSection]?
    var rowsUpdate: (rows: [TableRow], section: Int)?

    init(operation: TableStateOperation) {
        self.operation = operation
    }
}
