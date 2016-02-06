import Delta

struct FilterAction: ActionType {
    let filter: Filter

    func reduce(state: AppState) -> AppState {
        state.filter.value = filter
        return state
    }
}