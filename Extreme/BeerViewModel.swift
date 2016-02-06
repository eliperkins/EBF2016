import UIKit

struct BeerViewModel {
    let beer: Beer

    let ratingsViewModel: RatingsViewModel

    init(beer: Beer) {
        self.beer = beer
        self.ratingsViewModel = RatingsViewModel(brosRating: Int(beer.brosScore) ?? 0, usersRating: Int(beer.userScore) ?? 0)
    }
}
