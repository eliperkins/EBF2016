import UIKit

class BeerTableViewCell: UITableViewCell {

    var viewModel: BeerViewModel? {
        didSet {
        nameLabel.text = viewModel?.beer.name
        breweryLabel.text = viewModel?.beer.brewery
        styleLabel.text = viewModel?.beer.style
        ratingsView.viewModel = viewModel?.ratingsViewModel

        if let abv = viewModel?.beer.ABV {
            abvLabel.text = "\(abv)%"
        }
        }
    }

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.spacing = 4
        return stackView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        label.numberOfLines = 0
        return label
    }()

    let breweryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        label.numberOfLines = 0
        return label
    }()

    private let subheadlineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Horizontal
        stackView.distribution = .EqualSpacing
        return stackView
    }()

    let styleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        label.textColor = UIColor(white: 0.4125, alpha: 1.0)
        return label
    }()

    let abvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        label.textColor = UIColor(white: 0.4125, alpha: 1.0)
        return label
    }()

    let ratingsView: RatingsView = {
        let view = RatingsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(breweryLabel)
        subheadlineStackView.addArrangedSubview(styleLabel)
        subheadlineStackView.addArrangedSubview(abvLabel)
        stackView.addArrangedSubview(subheadlineStackView)
        stackView.addArrangedSubview(ratingsView)
        contentView.addSubview(stackView)

        let margins = contentView.layoutMarginsGuide
        let constraints = [
            stackView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor),
            stackView.topAnchor.constraintEqualToAnchor(margins.topAnchor),
            stackView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor),
            stackView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor)
        ]

        for constraint in constraints {
            constraint.active = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}