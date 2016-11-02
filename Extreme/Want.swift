import Foundation

struct Want: Equatable {
    let beerURL: URL
}

func == (lhs: Want, rhs: Want) -> Bool {
    return lhs.beerURL == rhs.beerURL
}
