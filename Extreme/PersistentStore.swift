import Foundation
import ReactiveCocoa
import ReactiveSwift

// Don't judge me for my sins in here.
class PersistentStore<T: Storable> {
    func values() -> [String] {
        let array = UserDefaults.standard.array(forKey: T.key()) ?? []
        return array.flatMap { $0 as? String }
    }

    func save(_ values: [T]) {
        UserDefaults.standard.set(values.map { $0.identifier }, forKey: T.key())
        UserDefaults.standard.synchronize()
    }

    func subscribe(_ property: MutableProperty<[T]>) -> Disposable {
        return property.producer.on(value: save).start()
    }
}

protocol Storable {
    static func key() -> String
    var identifier: String { get }
}

extension Want: Storable {
    static func key() -> String {
        return "want"
    }

    var identifier: String {
        return beerURL.absoluteString
    }
}

extension Try: Storable {
    static func key() -> String {
        return "try"
    }

    var identifier: String {
        return beerURL.absoluteString
    }
}
