
import Foundation
import ReSwiftDataSource


struct MyItem: Item {
    var sectionIndex: Int
    var cellClass: AnyClass = MyCell.self
    var bgColor: UIColor = .red

    init(_ sectionIndex: Int) {
        self.sectionIndex = sectionIndex
    }
}

struct MySection: Section {
    var items: [Item]
}
