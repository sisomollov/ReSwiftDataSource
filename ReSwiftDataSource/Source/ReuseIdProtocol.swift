
import Foundation

public protocol ReuseIdProtocol {
    var cellClass: AnyClass { get set }
}

extension ReuseIdProtocol {

    var reuseId: String {
        return String(describing: cellClass)
    }
}
