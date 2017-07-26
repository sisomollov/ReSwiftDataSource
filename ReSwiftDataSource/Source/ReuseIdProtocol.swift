
import Foundation

public protocol ReuseIdProtocol {
    var viewClass: AnyClass? { get set }
}

extension ReuseIdProtocol {

    var reuseId: String {
        return String(describing: viewClass)
    }
}
