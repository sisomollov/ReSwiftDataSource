
import Foundation
import ReSwiftDataSource

struct CollectState: DataSourceState {
    var operation: DataSourceStateOperation = .none
    var data: [ItemSection] = [
        CollectSection(title: "Section 1", headerItem: CollectHeaderItem(title: "Section 1"))
    ]
}
