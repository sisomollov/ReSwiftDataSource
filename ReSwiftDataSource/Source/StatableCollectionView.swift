
import UIKit



public protocol CollectionViewProtocol {
    var layouts: [String: CollectionCellLayout] { get set }
}

extension CollectionViewProtocol where Self: StatableCollectionView {

    public func addCellLayouts(_ layouts: CollectionCellLayout...) {

        layouts.forEach { layout in

            if let nibName = layout.nibName {
                let nib = UINib(nibName: nibName, bundle: nil)
                self.register(nib, forCellWithReuseIdentifier: layout.reuseId)
            } else {
                self.register(layout.cellClass, forCellWithReuseIdentifier: layout.reuseId)
            }

            self.layouts[layout.reuseId] = layout
        }
    }
}


public class StatableCollectionView: UICollectionView, CollectionViewProtocol {
    public var layouts: [String: CollectionCellLayout] = [:]
}
