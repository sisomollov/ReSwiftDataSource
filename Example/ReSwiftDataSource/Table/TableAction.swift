
import Foundation
import ReSwiftDataSource

struct TableAction: DataSourceAction {
    var operation: DataSourceStateOperation
    var sections: [ItemSection]?
    var items: [Item]?

    init(operation: DataSourceStateOperation) {
       self.operation = operation
    }
}
