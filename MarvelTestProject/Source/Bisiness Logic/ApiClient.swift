import Foundation

/// Клиент для работы с API
final class ApiClient {

    // MARK: - Private Properties

    private var baseUrl: String

    private(set) lazy var session = URLSession(configuration: .ephemeral)

    // MARK: - Initializers

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    /// Запрос в сеть
    func request<T>(
        _ endpoint: T,
        resultHandler: @escaping (Result<T.Content, NetworkError>) -> Void) where T: Endpoint {

        guard var request = try? endpoint.makeRequest() else {
            resultHandler(.failure(.requestError))
            return
        }

        request.url = URL(string: baseUrl + (request.url?.absoluteString ?? ""))

        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    resultHandler(.failure(.requestError))
                    return
                }

                guard let data = data else {
                    resultHandler(.failure(.noDataError))
                    return
                }

                do {
                    let responseModel = try endpoint.parse(from: response, with: data)
                    resultHandler(.success(responseModel))
                } catch let networkError {
                    guard let networkError = networkError as? NetworkError else {
                        resultHandler(.failure(.unknownError))
                        return
                    }
                    resultHandler(.failure(networkError))
                }
            }
        }.resume()
    }
}
