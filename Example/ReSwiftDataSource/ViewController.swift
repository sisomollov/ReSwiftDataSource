
import UIKit
import ReSwiftDataSource
import ReSwift

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: StatableCollectionView!

    var wrapper: StatableCollectionWrapper!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = CollectionCellLayout(cellClass: MyCell.self) { cell, model in
            guard let cell = cell as? MyCell else { return }
            guard let model = model as? MyItem else { return }

            cell.backgroundColor = model.bgColor
        }
        collectionView.addCellLayouts(layout)
        wrapper = StatableCollectionWrapper(statableView: collectionView)

        subscribeToStore()
    }

    @IBAction func addNew(_ sender: UIBarButtonItem) {
        let one = MyItem(0)
        let two = MyItem(0)
        let three = MyItem(0)

        store.dispatch(InsertAction.insertItems([one, two, three]))
    }

    private func subscribeToStore() {
        store.subscribe(self)
    }
}

extension ViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = MyState

    func newState(state: MyState) {
        wrapper.state = state
    }
}
