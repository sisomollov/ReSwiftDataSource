
import UIKit
import ReSwiftDataSource

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
        let section = MySection(items: [MyItem(), MyItem()])
        wrapper.state = MyState(sections: [section])

    }

}


