import DeepDiff
import Foundation

/// Модель менаджера
struct Character: Hashable, Codable, DiffAware {
    
    /// Идентификатор
    let id: Int
    
    /// Название
    let name: String
    
    /// Описание
    let description: String
    
    /// Ссылка на изображение с расширением
    let thumbnail: Thumbnail
    
    /// Комиксы
    let comics: Comics
    
    /// Серии
    let series: Series
    
    // достаточно посчитать хэш по айди
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// Серия
struct Series: Hashable, Codable {
    
    /// Количество
    let available: Int
}

/// Ссылка на изображение с расширением
struct Thumbnail: Hashable, Codable {
    
    /// Путь
    let path: String
    
    /// Расширение
    let `extension`: String
}

/// Комиксы
struct Comics: Hashable, Codable {
    
    /// Количество
    let available: Int
}
