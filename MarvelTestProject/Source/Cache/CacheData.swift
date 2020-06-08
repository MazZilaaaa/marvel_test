import Foundation

/// Работа с хеш данными
final class CacheData {
    
    // MARK: - Private Properties
    
    private let cache = NSCache<AnyObject, AnyObject>()
    
    // MARK: - Public Methods
    
    /// Получаем данные для отображения изображения
    func getImagesData(_ img: Thumbnail, imageSize: ImageSize, complition: @escaping ((Data?) -> Void)) {
        getImagesFromHash(img) { [weak self] data in
            if let data = data {
                complition(data)
            } else {
                self?.fetchImages(img, imageSize: imageSize) {
                    complition($0)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getImagesFromHash(_ img: Thumbnail, complition: @escaping ((Data?) -> Void)) {
        let cachedData = cache.object(forKey: img.path as AnyObject)
        complition(cachedData != nil ? cachedData as? Data : nil)
    }
    
    private func fetchImages(_ img: Thumbnail, imageSize: ImageSize, complition: @escaping ((Data?) -> Void)) {
        ImageHelper.fetchImage(img, imageSize: imageSize) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cache.setObject(data as AnyObject, forKey: img.path as AnyObject)
                complition(data)
            case .failure:
                complition(nil)
            }
        }
    }
}
