import Foundation
import Mapper
import ReactiveCocoa

let initialBeers = NSBundle.mainBundle()
    .URLForResource("beers", withExtension: "json")
    .flatMap { NSData(contentsOfURL: $0) }
    .flatMap { try? NSJSONSerialization.JSONObjectWithData($0, options: []) }
    .flatMap { $0 as? Array<NSDictionary> }
    .flatMap(Beer.from)

struct AppState {
    let beers: MutableProperty<[Beer]>
    let wants: MutableProperty<[Want]>
    let tries: MutableProperty<[Try]>

    private let wantDisposable: Disposable
    private let tryDisposable: Disposable

    init(beers: [Beer] = initialBeers!, wants: [Want] = [], tries: [Try] = []) {
        self.beers = MutableProperty(beers)
        self.wants = MutableProperty(wants)
        self.tries = MutableProperty(tries)

        wantDisposable = wantStore.subscribe(self.wants)
        tryDisposable = tryStore.subscribe(self.tries)
    }
}