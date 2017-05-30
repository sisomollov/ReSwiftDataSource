
import UIKit


public protocol TableViewProtocol {}

extension TableViewProtocol where Self: UITableView {
    public func append(layout: TableCellDescriber) {
        if let nibName = layout.nibName {
            let nib = UINib(nibName: nibName, bundle: nil)
            register(nib, forCellReuseIdentifier: layout.reuseId)
        } else {
            register(layout.cellClass, forCellReuseIdentifier: layout.reuseId)
        }
    }
}

extension UITableView: TableViewProtocol {}
