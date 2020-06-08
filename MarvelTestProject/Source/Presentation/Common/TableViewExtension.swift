import UIKit

extension UITableView {

    func deselectSelectedRow() {
        if let indexPathForSelectedRow = indexPathForSelectedRow {
            deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
}

// MARK: - UITableViewCell

protocol NibRepresentable: AnyObject {

    static var className: String { get }

    static var nib: UINib { get }
}

extension NibRepresentable {

    static var className: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: className, bundle: nil)
    }
}

typealias NibTableViewCell = UITableViewCell & NibRepresentable

extension UITableView {

    func registerCellNib<T>(_ cellType: T.Type) where T: NibTableViewCell {
        register(cellType.nib, forCellReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T>(_ cellType: T.Type, for indexPath: IndexPath) -> T where T: NibTableViewCell {
        let anyCell = dequeueReusableCell(withIdentifier: cellType.className, for: indexPath)

        guard let cell = anyCell as? T else {
            fatalError("Unexpected cell type \(anyCell)")
        }
        return cell
    }
}

// MARK: - UITableViewHeaderFooterView

typealias NibTableFooterView = UITableViewHeaderFooterView & NibRepresentable

extension UITableView {
    
    func registerFooterNib<T>(_ headerType: T.Type) where T: NibTableFooterView {
        register(headerType.nib, forHeaderFooterViewReuseIdentifier: headerType.className)
    }
    
    func dequeueReusableHeaderFooterView<T>(_ headerType: T.Type) -> T? where T: NibTableFooterView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: headerType.className) else {
            return nil
        }
        
        guard let header = view as? T else {
            fatalError("Unexpected footer type \(headerType)")
        }
        
        return header
    }
}
