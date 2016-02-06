import UIKit

struct RatingViewModel {
    let rating: Int

    let textColor: UIColor
    let text: String

    init(rating: Int) {
        self.rating = rating
        switch rating {
        case 95...100: textColor = UIColor(named: .Blue)
        case 90...95: textColor = UIColor(named: .Green)
        default: textColor = UIColor(white: 0.4125, alpha: 1.0)
        }
        self.text = rating == 0 ? "-" : String(rating)
    }
}