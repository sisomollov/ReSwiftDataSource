
import Foundation

public protocol ItemSection {
    var items: [Item] { get set }

    var headerTitle: String? { get }
    var footerTitle: String? { get }

    var headerItem: Item? { get }
    var footerItem: Item? { get }
}
