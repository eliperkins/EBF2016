import Foundation

struct Try: Equatable {
    let beerURL: URL
}

func == (lhs: Try, rhs: Try) -> Bool {
    return lhs.beerURL == rhs.beerURL
}
