
import Foundation
import ReSwift

public protocol ReloadableState: StateType {

    var sections: [Section] { get set }
    var insertItems: [IndexPath] { get set }
}

