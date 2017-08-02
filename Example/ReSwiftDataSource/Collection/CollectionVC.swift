
import UIKit
import ReSwiftDataSource

final class CollectionVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    var wrapper: Wrapper!

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        wrapper = Wrapper(collectionView: collectionView)
        let cell = Describer(viewClass: CollectCell.self)
        let header = Describer(nibName: String(describing: CollectHeader.self),
                               viewClass: CollectHeader.self, context: .header)

        collectionView.append(cell)
        collectionView.append(header)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = .init(width: 80, height: 50)
        layout.headerReferenceSize = .init(width: 0, height: 30)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(wrapper) { $0.select { $0.collectState } }

        guard var items = wrapper.section(index: 0)?.items else { return }
        let item1 = CollectItem("Cell 1")
        let item2 = CollectItem("Cell 2")
        items.append(item1)
        items.append(item2)

        store.dispatch( CollectAction.updateItems(items, in: 0) )
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(wrapper)
    }

    @IBAction func deleteLastItem() {
        guard var items = wrapper.section(index: 0)?.items else { return }
        if items.count > 0 {
            items.removeLast()
        }

        store.dispatch( CollectAction.updateItems(items, in: 0) )
    }
}
