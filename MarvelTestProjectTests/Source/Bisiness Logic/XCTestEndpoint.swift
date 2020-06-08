@testable import MarvelTestProject
import XCTest

extension XCTestCase {

    func assertGetHttpMethod(request: URLRequest, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(request.httpMethod, "GET", file: file, line: line)
        XCTAssertNil(request.httpBody, "GET запрос не должен иметь тело", file: file, line: line)
    }
    
    func assertURL(
        _ urlRequest: URLRequest,
        path: String,
        file: StaticString = #file,
        line: UInt = #line) {
        guard let url = urlRequest.url else {
            return XCTFail("Запрос не имеет URL", file: file, line: line)
        }
        
        XCTAssertEqual(
            url.absoluteString,
            path,
            "URL запроса не совпадает",
            file: file,
            line: line)
    }
    
    func assertURLQueryItem(
        _ request: URLRequest,
        expectedItem: URLQueryItem,
        file: StaticString = #file,
        line: UInt = #line) {
        guard let url = request.url else {
            return XCTFail("Запрос не имеет URL", file: file, line: line)
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return XCTFail("URL не удалось разбить на компоненты", file: file, line: line)
        }
        
        guard let queryItems = components.queryItems else {
            return XCTFail("Тело запроса не раскодируется в URL Query", file: file, line: line)
        }
        
        XCTAssert(queryItems.contains(expectedItem), file: file, line: line)
    }
}
