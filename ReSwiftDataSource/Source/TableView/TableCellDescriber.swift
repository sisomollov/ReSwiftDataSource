
import Foundation

public struct TableCellDescriber: ReuseIdProtocol {

    public var cellClass: AnyClass
    public var nibName: String?

    public init(cellClass: AnyClass, nibName: String? = nil) {
        self.cellClass = cellClass
        self.nibName = nibName
    }
    
}

public protocol TableCell {
    func apply(row: TableRow)
}
