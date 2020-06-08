import UIKit

/// View с лоудером
final class LoaderFooterView: NibTableFooterView {
    
    // MARK: - IBOutlets

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - UITableViewHeaderFooterView
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.startAnimating()
    }
}
