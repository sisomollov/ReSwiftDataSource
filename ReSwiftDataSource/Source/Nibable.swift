
import Foundation

protocol Nibable {}

extension Nibable {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
