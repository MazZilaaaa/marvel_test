import Foundation

/// Протокол для Endpoint с данными
protocol JsonEndpoint: Endpoint where Content: Decodable, Self: Codable {

    associatedtype ContentWrapper: Decodable = Content

    /// Получение контента
    func content(from root: ContentWrapper) -> Content
}

extension JsonEndpoint {

    /// Получение декодированного объекта типа Content
    func content(from response: URLResponse?, with body: Data) throws -> Content {
        try ApiValidatior.validate(response, with: body)

        guard let decodedData = try? JSONDecoder.default.decode(ResponseData<ContentWrapper>.self, from: body) else {
            throw NetworkError.dataDecodingError
        }
        return content(from: decodedData.data)
    }
}

extension JsonEndpoint where ContentWrapper == Content {

    /// Получение объекта
    func content(from root: ContentWrapper) -> Content { root }
}

extension JSONDecoder {
    static let `default` = JSONDecoder()
}

/// Response Data
private struct ResponseData<T>: Decodable where T: Decodable {

    /// Объект
    let data: T
}
