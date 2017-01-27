
import UIKit

public struct CollectionCellLayout<Cell: UICollectionViewCell> : ReusableViewLayout {
    public typealias View = Cell

    public var configureCell: (Cell) -> Void
}
