
import UIKit
import ReSwiftDataSource

final class CollectCell: UICollectionViewCell, ReusableView {
    let label = UILabel()
    var item: CollectItem? {
        didSet {
            label.text = item?.text
            label.sizeToFit()
        }
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .red
        contentView.addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()

        item = nil
    }

    // MARK: - CollectionReusable
    func apply(item: Item) {
        if let item = item as? CollectItem {
            self.item = item
        }
    }
}
