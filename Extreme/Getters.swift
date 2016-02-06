import ReactiveCocoa
import Result

extension Store {
    var activeBeers: SignalProducer<[Beer], NoError> {
        return state.value.filter.producer.flatMap(.Latest) { (filter: Filter) -> SignalProducer<[Beer], NoError> in
            switch filter {
            case .All: return self.state.value.beers.producer
            case .Tries:
                return combineLatest(self.state.value.beers.producer, self.state.value.tries.producer)
                    .flatMap(.Merge) { (beer, tries) -> SignalProducer<[Beer], NoError> in
                        let triedBeerURLs = tries.map { $0.beerURL }
                        return SignalProducer(value: beer.filter { triedBeerURLs.contains($0.URL) })
                    }
            case .Wants:
                return combineLatest(self.state.value.beers.producer, self.state.value.wants.producer)
                    .flatMap(.Merge) { (beer, wants) -> SignalProducer<[Beer], NoError> in
                        let wantedBeerURLs = wants.map { $0.beerURL }
                        return SignalProducer(value: beer.filter { wantedBeerURLs.contains($0.URL) })
                    }
            case .Hot:
                return self.state.value.beers.producer.map {
                    return $0.sort { $0.hotness() > $1.hotness() }
                }
            }
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