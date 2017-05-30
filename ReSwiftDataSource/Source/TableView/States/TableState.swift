
import Foundation
import ReSwift

public protocol TableState: StateType {

    var identifier: String { get set }
    var operation: TableStateOperation { get set }
    var data: [TableSection] { get set }

    init()
}


public enum TableStateOperation {
    case none, reset(TableSection), updateRows(section: Int), updateSections
}
