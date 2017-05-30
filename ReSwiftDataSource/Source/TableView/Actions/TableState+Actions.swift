
import Foundation
import ReSwift

public protocol TableAction: Action {
    var operation: TableStateOperation { get }
    var sections: [TableSection]? { get set }
    var rowsUpdate: (rows: [TableRow], section: Int)? { get set }

    init(operation: TableStateOperation)
}

extension TableAction {

    public static func updateSections(_ sections: [TableSection]) -> Self {
        var action = self.init(operation: .updateSections)
        action.sections = sections

        return action
    }

    public static func updateRows(_ rows: [TableRow], in section: Int) -> Self {
        var action = self.init(operation: .updateRows(section: section))
        action.rowsUpdate = (rows, section)

        return action
    }

    public static func reset(section: TableSection) -> Self {
        let action = self.init(operation: .reset(section))

        return action
    }
}
