import UIKit

class FilterSegmentedControl: UISegmentedControl {
    convenience init() {
        self.init(items: ["All", "Wants", "Tries", "Hot"])
    }

    override init(items: [AnyObject]?) {
        super.init(items: items)

        let filter = store.state.producer.flatMap(.Merge) {
            return $0.filter.producer
        }

        filter.startWithNext {
            switch $0 {
            case .All: self.selectedSegmentIndex = 0
            case .Wants: self.selectedSegmentIndex = 1
            case .Tries: self.selectedSegmentIndex = 2
            case .Hot: self.selectedSegmentIndex = 3
            }
        }

        addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        selectedSegmentIndex = 0

        addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func valueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: store.dispatch(FilterAction(filter: .All))
        case 1: store.dispatch(FilterAction(filter: .Wants))
        case 2: store.dispatch(FilterAction(filter: .Tries))
        case 3: store.dispatch(FilterAction(filter: .Hot))
        default: store.dispatch(FilterAction(filter: .All))
        }
    }
}
