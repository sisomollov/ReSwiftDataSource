
import UIKit

public protocol ReduxRegistrar {}

extension ReduxRegistrar where Self: UITableView {
    public func append(_ describer: Describer) {
        if let nibName = describer.nibName {
            let nib = UINib(nibName: nibName, bundle: nil)

            switch describer.context {
            case .cell:
                register(nib, forCellReuseIdentifier: describer.reuseId)
            case .header, .footer:
                register(nib, forHeaderFooterViewReuseIdentifier: describer.reuseId)
            }

            return
        }

        if let viewClass = describer.viewClass {
            switch describer.context {
            case .cell:
                register(viewClass, forCellReuseIdentifier: describer.reuseId)
            case .header, .footer:
                register(viewClass, forHeaderFooterViewReuseIdentifier: describer.reuseId)
            }
            return
        }
    }
}

extension ReduxRegistrar where Self: UICollectionView {
    public func append(_ describer: Describer) {
        if let nibName = describer.nibName {
            let nib = UINib(nibName: nibName, bundle: nil)

            switch describer.context {
            case .cell:
                register(nib, forCellWithReuseIdentifier: describer.reuseId)
            case .header:
                register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                         withReuseIdentifier: describer.reuseId)
            case .footer:
                register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                         withReuseIdentifier: describer.reuseId)
            }

            return
        }

        if let viewClass = describer.viewClass {
            switch describer.context {
            case .cell:
                register(viewClass, forCellWithReuseIdentifier: describer.reuseId)
            case .header:
                register(viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                         withReuseIdentifier: describer.reuseId)
            case .footer:
                register(viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                         withReuseIdentifier: describer.reuseId)
            }

            return
        }
    }
}

extension UITableView: ReduxRegistrar {}
extension UICollectionView: ReduxRegistrar {}
