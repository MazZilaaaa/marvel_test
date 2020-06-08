import Foundation

enum ImageSize: String {
    case portraitSmall = "portrait_small"
    case portraitIncredible = "portrait_incredible"
}

/// Helper для работы с изображением
struct ImageHelper {
    
    /// Получаем данные для отображения изображения
    static func fetchImage(
        _ img: Thumbnail,
        imageSize: ImageSize,
        resultHandler: @escaping (Result<Data, ImageLoadError>) -> Void) {
        
        let path = img.path.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: "\(path)/\(imageSize.rawValue).\(img.extension)") else {
            fatalError("Ошибка преобразования URL")
        }
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: url) {
                resultHandler(.success(data))
            } else {
                resultHandler(.failure(.failed))
            }
        }
    }
}
