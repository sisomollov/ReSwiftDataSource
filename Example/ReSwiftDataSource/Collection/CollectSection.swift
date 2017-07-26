
import Foundation
import ReSwiftDataSource

struct CollectSection: ItemSection {
    var items: [Item] = []

    var headerTitle: String?
    var footerTitle: String?

    var headerItem: Item?
    var footerItem: Item?

    init(title: String? = nil, headerItem: CollectHeaderItem) {
        headerTitle = title
        self.headerItem = headerItem
    }
}

extension CollectSection: Equatable {
    static func ==(lhs: CollectSection, rhs: CollectSection) -> Bool {
        return lhs.headerTitle == rhs.headerTitle
    }
}
