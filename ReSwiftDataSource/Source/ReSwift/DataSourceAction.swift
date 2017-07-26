
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
        var action = self.init(operation: .updateItems(section: section))
        action.items = items
        return action
    }
    public static func updateSections(_ sections: [ItemSection]) -> Self {
        var action = self.init(operation: .updateSections)
        action.sections = sections
        return action
    }
    public static func reset(section: ItemSection) -> Self {
        let action = self.init(operation: .reset(section))
        return action
    }
}
