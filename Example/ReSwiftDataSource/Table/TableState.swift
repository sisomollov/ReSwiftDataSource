
import Foundation
import ReSwiftDataSource

struct TableState: DataSourceState {
    var operation: DataSourceStateOperation = .none
    var data: [ItemSection] = [
        TableSection(title: "Section One", headerItem: TableHeaderItem(title: "Section One"))
    ]
}

extension TableState: Equatable {
    static func ==(lhs: TableState, rhs: TableState) -> Bool {
        return lhs.operation == rhs.operation
    }
}
