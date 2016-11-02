import Foundation
import Mapper
import ReactiveCocoa
import ReactiveSwift


let initialBeers: [Beer]? = Bundle.main
    .url(forResource: "beers", withExtension: "json")
    .flatMap { url in
        return try? Data(contentsOf: url)
    }
    .flatMap { try? JSONSerialization.jsonObject(with: $0, options: []) }
    .flatMap { $0 as? Array<NSDictionary> }
    .flatMap { dicts in
        return dicts.map(Mapper.init)
            .flatMap { try? Beer(map: $0) }
    }

struct AppState {
    let beers: MutableProperty<[Beer]>
    let wants: MutableProperty<[Want]>
    let tries: MutableProperty<[Try]>

    fileprivate let wantDisposable: Disposable
    fileprivate let tryDisposable: Disposable

    init(beers: [Beer] = initialBeers!, wants: [Want] = [], tries: [Try] = []) {
        self.beers = MutableProperty(beers)
        self.wants = MutableProperty(wants)
        self.tries = MutableProperty(tries)

        wantDisposable = wantStore.subscribe(self.wants)
        tryDisposable = tryStore.subscribe(self.tries)
    }
}
