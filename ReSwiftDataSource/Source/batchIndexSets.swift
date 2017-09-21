
import Foundation
import Changeset

func batchIndexSets<T>(from edits: [Edit<T>])
    -> (insertions: IndexSet, deletions: IndexSet, updates: IndexSet) {

        var insertions = IndexSet()
        var deletions = IndexSet()
        var updates = IndexSet()
        for edit in edits {
            let index = edit.destination

            switch edit.operation {
            case .deletion:
                deletions.insert(index)
            case .insertion:
                insertions.insert(index)
            case .move(let origin):
                deletions.insert(origin)
                insertions.insert(index)
            case .substitution:
                updates.insert(index)
            }
        }

        return (insertions, deletions, updates)
}
