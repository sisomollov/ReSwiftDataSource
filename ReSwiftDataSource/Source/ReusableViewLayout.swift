
import UIKit

public protocol ReusableViewLayout {
    associatedtype View: UIView

    var configureCell: (View) -> Void { get set }
}

extension ReusableViewLayout {

    public var className: View.Type {
        return View.self
    }
    public var reuseId: String {
        return String(describing: View.self)
    }
}
