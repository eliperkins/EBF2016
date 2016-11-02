import UIKit
import ReactiveSwift
import ReactiveCocoa
import SafariServices
import Result

class BeersViewController: UITableViewController {

    var viewModel = BeerListViewModel(beers: []) {
        didSet {
            self.tableView.reloadData()
        }
    }

    let storeSignal: SignalProducer<[Beer], NoError>

    init(storeSignal: SignalProducer<[Beer], NoError>, title: String) {
        self.storeSignal = storeSignal
        super.init(style: .plain)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerCell")
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension

        storeSignal.observe(on: QueueScheduler.main).startWithValues {
            self.viewModel = BeerListViewModel(beers: $0)
        }
    }
}

extension BeersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = self.viewModel.beers[indexPath.row]
        let viewController = SFSafariViewController(url: beer.URL)
        present(viewController, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let wantAction = UITableViewRowAction(style: .default, title: "Want") { (_, indexPath) in
            let beer = self.viewModel.beers[indexPath.row]
            let action = ToggleWantAction(want: Want(beerURL: beer.URL))
            store.dispatch(action)
            self.tableView.setEditing(false, animated: true)
        }
        wantAction.backgroundColor = UIColor(named: .orange)

        let triedAction = UITableViewRowAction(style: .default, title: "Tried") { (_, indexPath) in
            let beer = self.viewModel.beers[indexPath.row]
            let action = ToggleTryAction(try: Try(beerURL: beer.URL))
            store.dispatch(action)
            self.tableView.setEditing(false, animated: true)
        }
        triedAction.backgroundColor = UIColor(named: .blue)

        return [wantAction, triedAction]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath)
        if let beerCell = cell as? BeerTableViewCell {
            let beer = viewModel.beers[indexPath.row]
            beerCell.viewModel = BeerViewModel(beer: beer)
        }
        return cell
    }
}
