
import Foundation
import ReSwift

public enum DataSourceStateOperation: RawRepresentable, Equatable {
    case none, reset(ItemSection), updateItems(section: Int), updateSections

    // MARK: - RawRepresentable
    public typealias RawValue = String
    public var rawValue: String {
        switch self {
        case .none: return "None"
        case .reset: return "Reset"
        case .updateItems: return "Update Items"
        case .updateSections: return "Update Sections"
        }
    }
    public init?(rawValue: String) {
        return nil
    }

    // MARK: - Equatable
    public static func ==(lhs: DataSourceStateOperation, rhs: DataSourceStateOperation) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
