
import Foundation
import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: MyState?) -> MyState {
        let state = state ?? MyState(sections: [MySection(items: [])])

        switch action as? InsertAction {
        case .insertItems(let items)?:
            var sections = state.sections
            var insertedItems = [IndexPath]()
            items.forEach {
                var section = sections[$0.sectionIndex]
                let index = section.items.count
                section.items.append($0)

                sections[$0.sectionIndex] = section
                let indexPath = IndexPath(item: index, section: $0.sectionIndex)
                insertedItems.append(indexPath)
            }
            return MyState(sections: sections, insertItems: insertedItems)
        default:
            return state
        }
    }
}


enum InsertAction: Action {
    case insertItems([MyItem])
}


