
import Foundation
import ReSwift

public protocol DataSourceAction: Action {
    var operation: DataSourceStateOperation { get }
    var sections: [ItemSection]? { get set}
    var items: [Item]? { get set }

    init(operation: DataSourceStateOperation)
}

extension DataSourceAction {
    public static func updateItems(_ items: [Item], in section: Int) -> Self {
        let operation = DataSourceStateOperation(value: .updateItems(section: section))
        var action = self.init(operation: operation)
        action.items = items
        return action
    }
    public static func updateSections(_ sections: [ItemSection]) -> Self {
        let operation = DataSourceStateOperation(value: .updateSections)
        var action = self.init(operation: operation)
        action.sections = sections
        return action
    }

    /// Reset DataSource action
    ///
    /// - Parameter section: pass empty section
    /// - Returns: ReSwift Action
    public static func reset(section: ItemSection) -> Self {
        let operation = DataSourceStateOperation(value: .reset)
        var action = self.init(operation: operation)
        action.sections = [section]
        return action
    }
}
