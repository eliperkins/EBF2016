import Foundation

struct Try: Equatable {
    let beerURL: NSURL
}

func == (lhs: Try, rhs: Try) -> Bool {
    return lhs.beerURL == rhs.beerURL
}
