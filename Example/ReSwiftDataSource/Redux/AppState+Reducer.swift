
import Foundation
import ReSwift
import ReSwiftDataSource

// MARK: - Public API
func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    state.tableState = DataSourceReducer<TableState, TableAction>
        .reducer(action: action, state: state.tableState)
    state.collectState = DataSourceReducer<CollectState, CollectAction>
        .reducer(action: action, state: state.collectState)

    return state
}
