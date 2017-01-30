
import UIKit

public protocol Layout: ReuseIdProtocol {
    associatedtype Cell: UIView

    var nibName: String? { get set }
    var configureCell: (Cell, Item) -> Void { get set }
}

