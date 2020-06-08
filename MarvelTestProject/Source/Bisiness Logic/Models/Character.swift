import Foundation

/// Модель менаджера
struct Character: Codable {
    
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
}

/// Серия
struct Series: Codable {
    
    /// Количество
    let available: Int
}

/// Ссылка на изображение с расширением
struct Thumbnail: Codable {
    
    /// Путь
    let path: String
    
    /// Расширение
    let `extension`: String
}

/// Комиксы
struct Comics: Codable {
    
    /// Количество
    let available: Int
}
