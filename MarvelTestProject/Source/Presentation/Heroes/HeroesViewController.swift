import UIKit

/// Список героев
final class HeroesViewController: UIViewController, AlertPresentable {

    // MARK: - Constants
    
    private struct Constants {
        static let title = "Marvel"
    }
    
    // MARK: - IBOutlets

    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private Properties

    private let service = ServiceLayer.shared.networkService

    private let cacheImages = CacheData()
    
    private var isFetching = false {
        didSet {
            tableView.footerView(forSection: 0)?.isHidden = !isFetching
        }
    }
    
    private var page = 1 {
        didSet {
            fetchCharacters(page: page)
        }
    }
    
    private var characters: [Character] = [] {
        didSet {
            var arrayIndexPath = [IndexPath]()
            
            for item in 1 ... EndpointConstants.limit {
                arrayIndexPath.append(IndexPath(row: characters.count - item, section: 0))
            }
            tableView.insertRows(at: arrayIndexPath, with: .automatic)
        }
    }

    // MARK: - UIViewController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.deselectSelectedRow()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.title
        
        tableView.registerCellNib(HeroTableViewCell.self)
        tableView.registerFooterNib(LoaderFooterView.self)
        
        fetchCharacters(page: page)
    }
    
    // MARK: - Private Methods
    
    private func fetchCharacters(page: Int) {
        isFetching = true
        service.fetchCharacters(by: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters += response
            case .failure(let error):
                self?.showAlert(errorDescription: error.description)
            }
            self?.isFetching = false
        }
    }
}

// MARK: - UITableViewDelegate
extension HeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(DetailHeroViewController(characters[indexPath.row]), sender: nil)
    }
}

// MARK: - UITableViewDataSource
extension HeroesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(LoaderFooterView.self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(HeroTableViewCell.self, for: indexPath)
        
        cacheImages.getImagesData(character.thumbnail, imageSize: .portraitSmall) { data in
            if
                let imageData = data,
                let image = UIImage(data: imageData) {
                
                DispatchQueue.main.async {
                    cell.heroImage = image
                }
            }
        }
        
        cell.nameText = character.name
        cell.comicsCount = character.comics.available
        cell.historyText = character.description
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !isFetching {
                page += 1
            }
        }
    }
}
