import UIKit

class RatingsView: UIStackView {
    var viewModel: RatingsViewModel? {
        didSet {
        guard let viewModel = viewModel else { return }
        usersRatingView.ratingLabel.text = viewModel.usersRatingViewModel.text
        brosRatingView.ratingLabel.text = viewModel.brosRatingViewModel.text
        usersRatingView.ratingLabel.textColor = viewModel.usersRatingViewModel.textColor
        brosRatingView.ratingLabel.textColor = viewModel.brosRatingViewModel.textColor
        }
    }

    fileprivate let usersRatingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Users"
        return view
    }()

    fileprivate let brosRatingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Bros"
        return view
    }()

    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        axis = .horizontal
        spacing = 8

        distribution = .fillEqually

        addArrangedSubview(usersRatingView)
        addArrangedSubview(brosRatingView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class RatingView: UIStackView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout)
        label.textColor = UIColor(white: 0.6, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        axis = .vertical

        addArrangedSubview(titleLabel)
        addArrangedSubview(ratingLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
