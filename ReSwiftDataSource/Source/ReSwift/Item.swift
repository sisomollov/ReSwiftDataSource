
import Foundation

public protocol Item: ReuseIdProtocol {
    var sectionIndex: Int { get set }
}
