import Delta

struct AddWantAction: ActionType {
    let want: Want

    func reduce(state: AppState) -> AppState {
        state.wants.value = state.wants.value + [want]

        return state
    }
}

struct RemoveWantAction: ActionType {
    let want: Want

    func reduce(state: AppState) -> AppState {
        state.wants.value = state.wants.value.filter { $0 != self.want }

        return state
    }
}

struct ToggleWantAction: ActionType {
    let want: Want

    func reduce(state: AppState) -> AppState {
        if state.wants.value.contains(want) {
            return RemoveWantAction(want: want).reduce(state)
        } else {
            return AddWantAction(want: want).reduce(state)
        }
    }
}

struct AddTryAction: ActionType {
    let `try`: Try

    func reduce(state: AppState) -> AppState {
        state.tries.value = state.tries.value + [`try`]

        return state
    }
}

struct RemoveTryAction: ActionType {
    let `try`: Try

    func reduce(state: AppState) -> AppState {
        state.tries.value = state.tries.value.filter { $0 != self.`try` }

        return state
    }
}
