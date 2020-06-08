import XCTest

@testable import MarvelTestProject
final class MD5Tests: XCTestCase {

    func testMD5Cache() throws {
        let md5 = MD5(publicKey: "1", privateKey: "2", date: makeDate())
        
        XCTAssertEqual(md5.makeHashValue(), "658259bf9a93e8966e10e3db815acfd6")
    }
    
    private func makeDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: "2020-05-21") else {
            fatalError("Ошибка преобразования даты")
        }
        
        return date
    }
}
