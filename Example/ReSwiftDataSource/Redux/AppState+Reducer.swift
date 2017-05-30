
import Foundation
import ReSwift
import ReSwiftDataSource

// MARK: - Public API
func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    state.tableState = TableReducer<TestTableState, TestTableAction>.reducer(
        action: action, state: state.tableState)
    state.table2State = TableReducer<TestTableState, Test2TableAction>.reducer(
        action: action, state: state.table2State)

    return state
}
