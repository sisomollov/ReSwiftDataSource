
import Foundation
import ReSwiftDataSource

struct CollectAction: DataSourceAction {
    var operation: DataSourceStateOperation
    var sections: [ItemSection]?
    var items: [Item]?

    init(operation: DataSourceStateOperation) {
        self.operation = operation
    }
}
