struct RatingsViewModel {
    let brosRatingViewModel: RatingViewModel
    let usersRatingViewModel: RatingViewModel

    init(brosRating: Int, usersRating: Int) {
        brosRatingViewModel = RatingViewModel(rating: brosRating)
        usersRatingViewModel = RatingViewModel(rating: usersRating)
    }
}