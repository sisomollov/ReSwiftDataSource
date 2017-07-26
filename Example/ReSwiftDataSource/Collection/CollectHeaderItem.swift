
import Foundation
import ReSwiftDataSource

struct CollectHeaderItem: Item {
    var viewClass: AnyClass? = CollectHeader.self

    var title: String

    init(title: String) {
        self.title = title
    }
}
