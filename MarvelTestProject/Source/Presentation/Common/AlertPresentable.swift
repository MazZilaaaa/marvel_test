import UIKit

/// Протокол для отображения алертов
protocol AlertPresentable: AnyObject {}

extension AlertPresentable where Self: UIViewController {
    
    /// Показать ошибку модалкой
    func showAlert(errorDescription: String) {
        let alertController = UIAlertController(title: "Ошибка", message: errorDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
