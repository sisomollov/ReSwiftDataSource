
import Foundation
import ReSwift

public struct TableReducer<S: TableState, A: TableAction> {

    public static func reducer(action: Action, state: S) -> S {
        var state = state

        guard let action = action as? A else { return state }

        state.identifier = identifier(action: action, state: state.identifier)
        state.data       = data(action: action, state: state.data)
        state.operation  = operation(action: action, state: state.operation)

        return state
    }

    private static func identifier(action: A, state: String) -> String {
        switch action.operation {
        case .none:
            return state
        default:
            return UUID().uuidString
        }
    }

    private static func data(action: A, state: [TableSection]) -> [TableSection] {
        switch action.operation {
        case .updateSections:
            return action.sections ?? state
        case .updateRows:
            let (rows, section) = action.rowsUpdate!
            var state = state
            state[section].rows = rows

            return state
        case .reset(let section):
            return [section]
        default:
            return state
        }
    }

    private static func operation(action: A, state: TableStateOperation) -> TableStateOperation {
        return action.operation
    }
}
