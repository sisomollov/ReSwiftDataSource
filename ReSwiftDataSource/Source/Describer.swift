
import Foundation

public struct Describer: ReuseIdProtocol {
    public enum Context: String { case cell, header, footer }

    public var viewClass: AnyClass?
    public var nibName: String?
    public var context: Context


    public init(nibName: String, viewClass: AnyClass, context: Context = .cell) {
        self.nibName = nibName
        self.viewClass = viewClass
        self.context = context
    }
    public init(viewClass: AnyClass, context: Context = .cell) {
        self.viewClass = viewClass
        self.context = context
    }
}
