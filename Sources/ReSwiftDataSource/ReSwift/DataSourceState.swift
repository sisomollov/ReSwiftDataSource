
import Foundation
import ReSwift

public protocol DataSourceState: StateType {
    var operation: DataSourceStateOperation { get set }
    var data: [ItemSection] { get set }

    init()
}
