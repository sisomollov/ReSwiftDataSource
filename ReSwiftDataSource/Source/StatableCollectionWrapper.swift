
import UIKit
import ReSwift

public class StatableCollectionWrapper: NSObject {

    // MARK: - Public API
    public let statableView: StatableCollectionView
    public var state: ReloadableState?

    public init(statableView: StatableCollectionView) {
        self.statableView = statableView
        super.init()
        
        self.statableView.dataSource = self
    }

    // MARK: - Private API
}

// MARK: - UICollectionViewDataSource
extension StatableCollectionWrapper: UICollectionViewDataSource {

    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        var number = 0

        if let section = state?.sections[section] {
            number = section.items.count
        }

        return number
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let section = state?.sections[indexPath.section] {
            let item = section.items[indexPath.item]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: item.reuseId,
                for: indexPath
            )
            guard let layout = statableView.layouts[item.reuseId] else {
                fatalError("missing to register cell for reuseID \(item.reuseId)")
            }

            layout.configureCell(cell, item)

            return cell
        } else {
            fatalError("probably state is nil")
        }
    }
}

//extension StatableCollectionWrapper: UICollectionViewDelegateFlowLayout {
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: UIScreen.main.bounds.width, height: 50)
//    }
//}

// MARK: - StoreSubscriber
extension StatableCollectionWrapper: StoreSubscriber {
    public typealias StoreSubscriberStateType = ReloadableState

    public func newState(state: ReloadableState) {
        self.state = state
    }
}
