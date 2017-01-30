
import Foundation
import ReSwiftDataSource


struct MyItem: Item {
    var cellClass: AnyClass = MyCell.self
    var bgColor: UIColor = .red
}

struct MySection: Secetion {
    var items: [Item]
}
