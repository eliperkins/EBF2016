import UIKit
import ReactiveSwift
import ReactiveCocoa

class BreweryListViewController: UITableViewController {

    var viewModel = BreweryListViewModel(breweries: []) {
        didSet {
        tableView.reloadData()
        }
    }

    convenience init() {
        self.init(style: .plain)
    }

    override init(style: UITableViewStyle) {
        super.init(style: style)
        title = "Breweries"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BreweryCell")

        store.allBreweries.observe(on: QueueScheduler.main).startWithValues {
            self.viewModel = BreweryListViewModel(breweries: $0)
        }
    }
}

extension BreweryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.breweries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryCell", for: indexPath)
        let brewery = viewModel.breweries[indexPath.row]
        cell.textLabel?.text = brewery.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brewery = viewModel.breweries[indexPath.row]
        let beerSignal = store.beers(by: brewery)
        let viewController = BeersViewController(storeSignal: beerSignal, title: brewery.name)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
