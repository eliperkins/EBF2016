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
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        label.numberOfLines = 0
        return label
    }()

    let breweryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        label.numberOfLines = 0
        return label
    }()

    fileprivate let subheadlineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    let styleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        label.textColor = UIColor(white: 0.4125, alpha: 1.0)
        return label
    }()

    let abvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
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
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: margins.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ]

        for constraint in constraints {
            constraint.isActive = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
