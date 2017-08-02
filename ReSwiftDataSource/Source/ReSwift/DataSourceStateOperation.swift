
import Foundation
import ReSwift

public struct DataSourceStateOperation: Equatable {
    public enum Operation {
        case none, reset, updateItems(section: Int), updateSections
    }
    public var value: Operation = .none {
        didSet { id = UUID().uuidString }
    }
    internal var id: String = UUID().uuidString

    public static func ==(lhs: DataSourceStateOperation, rhs: DataSourceStateOperation) -> Bool {
        return lhs.id == rhs.id
    }

    public init(value: Operation = .none) {
        self.value = value
    }
}


