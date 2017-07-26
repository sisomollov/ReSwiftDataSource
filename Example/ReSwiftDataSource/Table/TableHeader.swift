
import UIKit
import ReSwiftDataSource

final class TableHeader: UITableViewHeaderFooterView, ReusableView {

    var item: TableHeaderItem? {
        didSet {
            label.text = item?.title
            label.sizeToFit()
        }
    }
    let label = UILabel()

    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        label.textColor = .red
        contentView.addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()

        item = nil
        label.text = ""
    }

    // MARK: - TableReusable
    func apply(item: Item) {
        if let row = item as? TableHeaderItem {
            self.item = row
        }
    }
}
