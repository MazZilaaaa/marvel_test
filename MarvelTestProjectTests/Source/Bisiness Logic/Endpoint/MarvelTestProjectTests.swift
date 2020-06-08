@testable import MarvelTestProject
import XCTest

final class CharactersEndpointTests: XCTestCase {

    private var endpoint: CharactersEndpoint!
    private var request: URLRequest!
    
    override func setUpWithError() throws {
        endpoint = CharactersEndpoint(page: 1)
        request = try endpoint.makeRequest()
    }
    
    func testCharactersEndpointMethod() throws {
        assertGetHttpMethod(request: request)
    }
    
    func testURLQueryItems() {
        let queryItemApiKey = URLQueryItem(name: "apikey", value: EndpointConstants.publicKey)
        let queryItemTimeStamp = URLQueryItem(name: "ts", value: endpoint.cache.makeTimeStampString())
        let queryItemHash = URLQueryItem(name: "hash", value: endpoint.cache.makeHashValue())
        let queryItemLimit = URLQueryItem(name: "limit", value: String(EndpointConstants.limit))
        let queryItemOffset = URLQueryItem(name: "offset", value: "0")
        
        assertURLQueryItem(request, expectedItem: queryItemApiKey)
        assertURLQueryItem(request, expectedItem: queryItemTimeStamp)
        assertURLQueryItem(request, expectedItem: queryItemHash)
        assertURLQueryItem(request, expectedItem: queryItemLimit)
        assertURLQueryItem(request, expectedItem: queryItemOffset)
    }
}
