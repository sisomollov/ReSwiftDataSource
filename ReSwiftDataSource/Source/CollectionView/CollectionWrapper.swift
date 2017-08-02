
import UIKit
import ReSwift
import Changeset

open class CollectionWrapper<Section, I, State>: NSObject, UICollectionViewDataSource,
    StoreSubscriber
where Section: ItemSection & Equatable, I: Item & Equatable, State: DataSourceState {

    public var collectionView: UICollectionView?
    public var state: State = State()

    // MARK: - Init
    public init(collectionView: UICollectionView) {
        super.init()

        self.collectionView = collectionView
        self.collectionView?.dataSource = self
    }

    // MARK: - Updates
    public func performUpdates(state: State) {
        var sourceState = self.state

        switch state.operation.value {
        case .updateItems(let section):
            guard let sourceItems = sourceState.data[section].items as? [I] else { return }
            guard let targetItems = state.data[section].items as? [I] else { return }

            let edits = Changeset.edits(from: sourceItems, to: targetItems)
            collectionView?.performBatchUpdates({
                self.state = state
                self.collectionView?.update(with: edits, in: section, completion: nil)
            }, completion: nil)
        case .updateSections, .reset:
            guard let sourceSections = sourceState.data as? [Section] else { return }
            guard let targetSections = state.data as? [Section] else { return }
            let edits = Changeset.edits(from: sourceSections, to: targetSections)

            guard !edits.isEmpty else { return }
            let (insertions, deletions, updates) = batchIndexSets(from: edits)

            collectionView?.performBatchUpdates({
                self.state = state
                if !deletions.isEmpty { self.collectionView?.deleteSections(deletions) }
                if !insertions.isEmpty { self.collectionView?.insertSections(insertions) }
                if !updates.isEmpty { self.collectionView?.reloadSections(updates) }
            }, completion: nil)

        default: break
        }
    }

    // MARK: - DataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        assert(state.data.count > 0, "CollectionState.data must have at least one section")
        return state.data.count
    }
    public func collectionView
        (_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = state.data[section].items.count

        return count
    }
    public func collectionView
        (_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {

        let section = state.data[indexPath.section]
        let item = section.items[indexPath.item]

        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: item.reuseId, for: indexPath)

        if let cell = cell as? ReusableView {
            cell.apply(item: item)
        }

        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let error = { fatalError("Wrapper: missing item for supplimentary view of kind: \(kind)") }
        guard let section = section(index: indexPath.section) else { error() }

        if kind == UICollectionElementKindSectionHeader {
            guard let item = section.headerItem else { error() }
            let view = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: item.reuseId, for: indexPath)
            if let view = view as? ReusableView {
                view.apply(item: item)
            }
            return view
        }

        if kind == UICollectionElementKindSectionFooter {
            guard let item = section.footerItem else { error() }
            let view = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: item.reuseId, for: indexPath)
            if let view = view as? ReusableView {
                view.apply(item: item)
            }
            return view
        }

        fatalError(
            "Wrapper: Missing handling for supplimentary view of kind: \(kind). You need to override the collectionView:viewForSupplementaryElementOfKind:at: method if your supp view isn't a UICollectionElementKindSectionHeader or UICollectionElementKindSectionFooter"
        )
    }

    // MARK: - Public API
    public func section(index: Int) -> Section? {
        if let section = state.data[index] as? Section {
            return section
        }
        return nil
    }
}


// MARK: - StoreSubscriber
extension CollectionWrapper {
    public typealias StoreSubscriberStateType = State
    public func newState(state: State) {
        performUpdates(state: state)
    }
}
