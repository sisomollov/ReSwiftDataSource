
import Foundation
import ReSwiftDataSource

extension TableVC {
    final class Wrapper: TableWrapper<TableSection, TableRow, TableState>, UITableViewDelegate {

        // MARK: - Override
        override init(tableView: UITableView) {
            super.init(tableView: tableView)

            tableView.delegate = self
        }

        // MARK: - Delegate
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            guard let headerItem = self.section(index: section)?.headerItem else { return nil }
            return reusableView(item: headerItem)
        }
    }
}
