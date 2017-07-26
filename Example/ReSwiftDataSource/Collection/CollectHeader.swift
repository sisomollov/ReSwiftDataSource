
import UIKit
import ReSwiftDataSource

final class CollectHeader: UICollectionReusableView, ReusableView {
    
    @IBOutlet weak var label: UILabel!
    var item: CollectHeaderItem? {
        didSet {
            label.text = item?.title
        }
    }

    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()

        item = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Reusable
    func apply(item: Item) {
        if let item = item as? CollectHeaderItem {
            self.item = item
        }
    }
}
