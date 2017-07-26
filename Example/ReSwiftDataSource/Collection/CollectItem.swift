
import Foundation
import ReSwiftDataSource

struct CollectItem: Item {
    var viewClass: AnyClass? = CollectCell.self
    var text: String

    init(_ text: String) {
        self.text = text
    }
}

extension CollectItem: Equatable {
    static func ==(lhs: CollectItem, rhs: CollectItem) -> Bool {
        return lhs.text == rhs.text
    }
}
