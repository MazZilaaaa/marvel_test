import Foundation

/// Ошибки при работе с Api
enum NetworkError: Error {

    /// Ошибка декодирования данных
    case dataDecodingError

    /// Ошибка сервера
    case requestError

    /// Ошибка получения данных
    case noDataError

    /// Сервер прислал ошибку
    ///
    /// - parameter code: код ошибки
    case serverError(code: Int)

    /// Неизвестная ошибка
    case unknownError
}

extension NetworkError {

    /// Описание ошибки
    var description: String {
        switch self {
        case .dataDecodingError:
            return "Ошибка декодирования данных"
        case .requestError:
            return "Ошибка сервера"
        case .noDataError:
            return "Ошибка получения данных"
        case .serverError(let code):
            return makeServerErrorDescription(by: code)
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }

    /// Создание ошибки по http коду
    func makeServerErrorDescription(by code: Int) -> String {
        switch code {
        case 400:
            return "Ошибка валидации"
        case 401:
            return """
                Ошибка авторизации, пожалуйства добавьте в проект публичные и приватные ключи.
                Вы можете получить их здесь https://developer.marvel.com/account
            """
        case 403:
            return "Доступ запрещён"
        case 404:
            return "Страница не найдена"
        default:
            return "Неизвестная ошибка сервера"
        }
    }
}
