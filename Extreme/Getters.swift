import ReactiveSwift
import ReactiveCocoa
import Result

extension Store {
    var allBeers: SignalProducer<[Beer], NoError> {
        return state.value.beers.producer
    }

    var wantedBeers: SignalProducer<[Beer], NoError> {
        return SignalProducer
            .combineLatest(state.value.beers.producer, state.value.wants.producer)
            .flatMap(.merge) { (beer, wants) -> SignalProducer<[Beer], NoError> in
                let wantedBeerURLs = wants.map { $0.beerURL }
                return SignalProducer(value: beer.filter { wantedBeerURLs.contains($0.URL) })
        }
    }

    var triedBeers: SignalProducer<[Beer], NoError> {
        return SignalProducer
            .combineLatest(state.value.beers.producer, state.value.tries.producer)
            .flatMap(.merge) { (beer, tries) -> SignalProducer<[Beer], NoError> in
                let triedBeerURLs = tries.map { $0.beerURL }
                return SignalProducer(value: beer.filter { triedBeerURLs.contains($0.URL) })
        }
    }

    var wantedAndNotTried: SignalProducer<[Beer], NoError> {
        return SignalProducer
            .combineLatest(state.value.beers.producer, state.value.tries.producer, state.value.wants.producer)
            .flatMap(.merge) { (beer, tries, wants) -> SignalProducer<[Beer], NoError> in
                let wantedBeerURLs = wants.map { $0.beerURL }
                let triedBeerURLs = tries.map { $0.beerURL }
                let wantedAndNotTriedURLs = wantedBeerURLs.filter { !triedBeerURLs.contains($0) }
                return SignalProducer(value: beer.filter { wantedAndNotTriedURLs.contains($0.URL) })
        }
    }

    var hotBeers: SignalProducer<[Beer], NoError> {
        return state.value.beers.producer.map {
            return $0.sorted { $0.hotness() > $1.hotness() }
        }
    }

    var allBreweries: SignalProducer<[Brewery], NoError> {
        return state.value.beers.producer.flatMap(.latest) { (beers) -> SignalProducer<[Brewery], NoError> in
            let breweryNames: [String] = beers.map { $0.brewery }.reduce([]) {
                if $0.contains($1) {
                    return $0
                }

                return $0 + [$1]
            }
            return SignalProducer(value: breweryNames.map(Brewery.init))
        }
    }

    func beers(by brewery: Brewery) -> SignalProducer<[Beer], NoError> {
        return state.value.beers.producer.map {
            return $0.filter { $0.brewery == brewery.name }
        }
    }
}

private extension Beer {
    func hotness() -> Double {
        let users = Int(userScore)

        let hadCount = Int(hads)

        let usersWeighted = users.flatMap { Double($0) * 0.5 }

        let hadWeigthed = hadCount.flatMap { (Double($0)/16000) * 100 * 0.3 } // 16000 ~= total hads value
        let reviewWeigthed: Double?
        if let reviewCount = Int(reviews), let reviewAvg = Double(avg) {
            reviewWeigthed = (Double(reviewCount) * reviewAvg / 7000) * 0.2 // 7000 ~= total reviews
        } else {
            reviewWeigthed = nil
        }

        return [usersWeighted, hadWeigthed, reviewWeigthed].reduce(Double(0)) { (acc, next) in
            guard let next = next else { return acc }
            return acc + next
        }
    }
}
