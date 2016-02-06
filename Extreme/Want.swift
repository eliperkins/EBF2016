import Foundation

struct Want: Equatable {
    let beerURL: NSURL
}

func == (lhs: Want, rhs: Want) -> Bool {
    return lhs.beerURL == rhs.beerURL
}