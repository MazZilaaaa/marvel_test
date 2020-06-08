import UIKit

/// Детализация героя
final class DetailHeroViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var comicsCountLabel: UILabel!
    @IBOutlet private var heroImage: UIImageView!
    @IBOutlet private var historyLabel: UILabel!
    @IBOutlet private var seriesCountLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var character: Character
    
    // MARK: - Initializer
    
    init(_ character: Character) {
        self.character = character
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character.name
        
        ImageHelper.fetchImage(character.thumbnail, imageSize: .portraitIncredible) { [weak self] result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.heroImage.image = image
                    }
                }
            case .failure:
                break
            }
        }
        
        historyLabel.text = character.description
        comicsCountLabel.text = "Number of comics: \(character.comics.available)"
        seriesCountLabel.text = "Number of series: \(character.series.available)"
    }
}
