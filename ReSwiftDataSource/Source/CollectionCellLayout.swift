
import UIKit

public struct CollectionCellLayout: Layout {
    public typealias Cell = UICollectionViewCell

    public var cellClass: AnyClass
    public var nibName: String?
    public var configureCell: (UICollectionViewCell, Item) -> Void

    public init(
        cellClass: AnyClass,
        nibName: String? = nil,
        configureCell: @escaping (UICollectionViewCell, Item) -> Void) {

        self.cellClass = cellClass
        self.nibName = nibName
        self.configureCell = configureCell
    }
}
