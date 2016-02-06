import ReactiveCocoa
import Delta
import Result

extension MutableProperty: ObservablePropertyType {
    public typealias ValueType = Value
}

struct Store: StoreType {
    var state: MutableProperty<AppState>

    init(state: AppState) {
        self.state = MutableProperty(state)
    }
}

let wantStore = PersistentStore<Want>()
let tryStore = PersistentStore<Try>()

let wants = wantStore.values().map { Want(beerURL: NSURL(string: $0)!) }
let tries = tryStore.values().map { Try(beerURL: NSURL(string: $0)!) }

let initialState = AppState(wants: wants, tries: tries)
var store = Store(state: initialState)
