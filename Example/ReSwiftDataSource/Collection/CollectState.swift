
import Foundation
import ReSwiftDataSource

struct CollectState: DataSourceState {
    var operation: DataSourceStateOperation = .init()
    var data: [ItemSection] = [
        CollectSection(title: "Section 1", headerItem: CollectHeaderItem(title: "Section 1"))
    ]
}

extension CollectState: Equatable {
    static func ==(lhs: CollectState, rhs: CollectState) -> Bool {
        return lhs.operation == rhs.operation
    }
}
