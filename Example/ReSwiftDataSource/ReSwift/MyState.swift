
import Foundation
import ReSwiftDataSource

struct MyState: ReloadableState {

    var sections: [Section]
    var insertItems: [IndexPath]
    var deletedItems: [IndexPath]

    init(
        sections: [Section],
        insertItems: [IndexPath] = [],
        deletedItems: [IndexPath] = []
    ) {

        self.sections = sections
        self.insertItems = insertItems
        self.deletedItems = deletedItems
    }
}
