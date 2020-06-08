import Foundation

/// Endpoint для персонажей
struct CharactersEndpoint: JsonEndpoint {
    
    /// Страница
    let page: Int

    typealias Content = [Character]

    /// Создание реквеста
    func makeRequest() throws -> URLRequest {
        try makeGetRequest(path: "v1/public/characters", queryItems: [
            URLQueryItem(name: "limit", value: String(EndpointConstants.limit)),
            URLQueryItem(name: "offset", value: String(EndpointConstants.limit * (page - 1)))
        ])
    }

    /// Парсинг в объект
    func parse(from response: URLResponse?, with body: Data) throws -> Content {
        try content(from: response, with: body)
    }

    /// Получение из верхнего объекта
    func content(from root: CharacterDataContainer) -> Content { root.results }
}

/// Обертка для получения героев
struct CharacterDataContainer: Decodable {

    /// Обертка
    let results: [Character]
}
