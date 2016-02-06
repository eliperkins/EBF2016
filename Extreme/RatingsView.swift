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

    private let usersRatingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Users"
        return view
    }()

    private let brosRatingView: RatingView = {
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

        axis = .Horizontal
        spacing = 8

        distribution = .FillEqually

        addArrangedSubview(usersRatingView)
        addArrangedSubview(brosRatingView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class RatingView: UIStackView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCallout)
        label.textColor = UIColor(white: 0.6, alpha: 1.0)
        label.textAlignment = .Center
        return label
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3)
        label.textColor = UIColor(white: 0.8, alpha: 1.0)
        label.textAlignment = .Center
        return label
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        axis = .Vertical

        addArrangedSubview(titleLabel)
        addArrangedSubview(ratingLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}