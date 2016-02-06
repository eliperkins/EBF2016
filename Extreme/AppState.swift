import Foundation
import Mapper
import ReactiveCocoa

let initialBeers = NSBundle.mainBundle()
    .URLForResource("beers", withExtension: "json")
    .flatMap { NSData(contentsOfURL: $0) }
    .flatMap { try? NSJSONSerialization.JSONObjectWithData($0, options: []) }
    .flatMap { $0 as? Array<NSDictionary> }
    .flatMap(Beer.from)

enum Filter {
    case All
    case Wants
    case Tries
    case Hot
}

struct AppState {
    let beers: MutableProperty<[Beer]>
    let wants: MutableProperty<[Want]>
    let tries: MutableProperty<[Try]>
    let filter: MutableProperty<Filter>

    private let wantDisposable: Disposable
    private let tryDisposable: Disposable

    init(beers: [Beer] = initialBeers!, wants: [Want] = [], tries: [Try] = [], filter: Filter = .All) {
        self.beers = MutableProperty(beers)
        self.wants = MutableProperty(wants)
        self.tries = MutableProperty(tries)
        self.filter = MutableProperty(filter)

        wantDisposable = wantStore.subscribe(self.wants)
        tryDisposable = tryStore.subscribe(self.tries)
    }
}