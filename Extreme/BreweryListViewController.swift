import UIKit
import ReactiveCocoa

class BreweryListViewController: UITableViewController {

    var viewModel = BreweryListViewModel(breweries: []) {
        didSet {
        tableView.reloadData()
        }
    }

    convenience init() {
        self.init(style: .Plain)
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
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "BreweryCell")

        store.allBreweries.observeOn(QueueScheduler.mainQueueScheduler).startWithNext {
            self.viewModel = BreweryListViewModel(breweries: $0)
        }
    }
}

extension BreweryListViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.breweries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BreweryCell", forIndexPath: indexPath)
        let brewery = viewModel.breweries[indexPath.row]
        cell.textLabel?.text = brewery.name
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let brewery = viewModel.breweries[indexPath.row]
        let beerSignal = store.beersByBrewery(brewery)
        let viewController = BeersViewController(storeSignal: beerSignal, title: brewery.name)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
