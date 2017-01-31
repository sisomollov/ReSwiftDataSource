
import Foundation
import ReSwiftDataSource

struct MyState: ReloadableState {
    var sections: [Section]
    var insertItems: [IndexPath]

    init(
        sections: [Section],
        insertItems: [IndexPath] = []) {

        self.sections = sections
        self.insertItems = insertItems
    }
}
