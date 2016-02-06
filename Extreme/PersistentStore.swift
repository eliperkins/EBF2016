import Foundation
import ReactiveCocoa

class PersistentStore<T: Storable> {
    func values() -> [String] {
        let array = NSUserDefaults.standardUserDefaults().arrayForKey(T.key()) ?? []
        return array.flatMap { $0 as? String }
    }

    func save(values: [T]) {
        NSUserDefaults.standardUserDefaults().setObject(values.map { $0.identifier }, forKey: T.key())
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func subscribe(property: MutableProperty<[T]>) -> Disposable {
        return property.producer.on(next: save).start()
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
