
import Foundation
import ReSwift

open class DataSourceReducer<State: DataSourceState, Action: DataSourceAction> {
    public class func reducer(action: ReSwift.Action, state: State) -> State {
        var state = state

        guard let action = action as? Action else { return state }

        state.data = data(action: action, state: state.data)
        state.operation = operation(action: action, state: state.operation)

        return state
    }

    // MARK: - Private
    private static func data(action: Action, state: [ItemSection]) ->
        [ItemSection] {
            switch action.operation.value {
            case .updateItems(let section):
                guard let items = action.items else { return state }
                var state = state
                state[section].items = items
                return state
            case .updateSections, .reset:
                return action.sections ?? state
            default:
                return state
            }
    }
    private static func operation(action: Action, state: DataSourceStateOperation) ->
        DataSourceStateOperation {
            return action.operation
    }
}
