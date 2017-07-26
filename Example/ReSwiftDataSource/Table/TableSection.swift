
import Foundation
import ReSwiftDataSource

struct TableSection: ItemSection, Equatable {
    let title: String
    var items: [Item] = []

    var headerTitle: String? {
        return title
    }
    var footerTitle: String? {
        return "Footer Text"
    }

    var headerItem: Item?
    var footerItem: Item?

    // MARK: - Init
    init(title: String, headerItem: TableHeaderItem) {
        self.title = title
        self.headerItem = headerItem
    }

    // MARK: - Equatable
    static func ==(lhs: TableSection, rhs: TableSection) -> Bool {
        return lhs.title == rhs.title
    }
}
