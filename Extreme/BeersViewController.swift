import UIKit
import ReactiveCocoa
import SafariServices

class BeersViewController: UITableViewController {

    var viewModel = BeerListViewModel(beers: []) {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(BeerTableViewCell.self, forCellReuseIdentifier: "BeerCell")
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension

        navigationItem.titleView = FilterSegmentedControl()

        store.activeBeers.observeOn(QueueScheduler.mainQueueScheduler).startWithNext {
            self.viewModel = BeerListViewModel(beers: $0)
        }
    }
}

extension BeersViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let beer = self.viewModel.beers[indexPath.row]
        let viewController = SFSafariViewController(URL: beer.URL)
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let wantAction = UITableViewRowAction(style: .Default, title: "Want") { (_, indexPath) in
            let beer = self.viewModel.beers[indexPath.row]
            let action = ToggleWantAction(want: Want(beerURL: beer.URL))
            store.dispatch(action)
            self.tableView.setEditing(false, animated: true)
        }
        wantAction.backgroundColor = UIColor(named: .Orange)

        let triedAction = UITableViewRowAction(style: .Default, title: "Tried") { (_, indexPath) in
            let beer = self.viewModel.beers[indexPath.row]
            let action = AddTryAction(try: Try(beerURL: beer.URL))
            store.dispatch(action)
            self.tableView.setEditing(false, animated: true)
        }
        triedAction.backgroundColor = UIColor(named: .Blue)

        return [wantAction, triedAction]
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeerCell", forIndexPath: indexPath)
        if let beerCell = cell as? BeerTableViewCell {
            let beer = viewModel.beers[indexPath.row]
            beerCell.viewModel = BeerViewModel(beer: beer)
        }
        return cell
    }
}