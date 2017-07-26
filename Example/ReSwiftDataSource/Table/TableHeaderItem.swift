
import Foundation
import ReSwiftDataSource

struct TableHeaderItem: Item {
    var viewClass: AnyClass? = TableHeader.self
    var title: String

    init(title: String) {
        self.title = title
    }
}
