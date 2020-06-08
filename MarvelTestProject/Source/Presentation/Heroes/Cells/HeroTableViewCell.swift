import UIKit

/// Ячейка с героем
final class HeroTableViewCell: NibTableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var comicsCountLabel: UILabel!
    @IBOutlet private var historyLabel: UILabel!
    @IBOutlet private var heroImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    // MARK: - Public Properties
    
    /// Картинка персонажа
    var heroImage: UIImage = #imageLiteral(resourceName: "NoImage") {
        didSet {
            heroImageView.image = heroImage
        }
    }
    
    /// Имя персонажа
    var nameText = "" {
        didSet {
            nameLabel.text = nameText
        }
    }
    
    /// Количество комиксов героя
    var comicsCount = 0 {
        didSet {
            comicsCountLabel.text = "Number of comics: \(comicsCount)"
        }
    }
    
    /// Историю героя
    var historyText = "" {
        didSet {
            historyLabel.text = historyText
        }
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        heroImageView.image = nil
    }
}
