@testable import MarvelTestProject
import XCTest

final class CharacterTests: XCTestCase {

    func testLoggedTimeInit() {
        let character = Character(
            id: 101,
            name: "Marvel Character",
            description: "Some description",
            thumbnail: Thumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/3/80/4c00358ec7548",
                extension: "jpg"),
            comics: Comics(available: 10),
            series: Series(available: 12))
        
        XCTAssertEqual(character.id, 101)
        XCTAssertEqual(character.name, "Marvel Character")
        XCTAssertEqual(character.description, "Some description")
        XCTAssertEqual(character.thumbnail.path, "https://i.annihil.us/u/prod/marvel/i/mg/3/80/4c00358ec7548")
        XCTAssertEqual(character.thumbnail.extension, "jpg")
        XCTAssertEqual(character.comics.available, 10)
        XCTAssertEqual(character.series.available, 12)
    }
}
