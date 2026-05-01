import XCTest
@testable import Wander

final class WanderTests: XCTestCase {

    func testStrangerCharacterCreation() throws {
        let character = StrangerCharacter(
            id: "test-id",
            name: "TestName",
            archetype: .wanderer,
            mood: .thoughtful,
            backstory: "Test backstory",
            avatarSymbol: "person.fill",
            glowColor: "#F5A623"
        )

        XCTAssertEqual(character.name, "TestName")
        XCTAssertEqual(character.archetype, .wanderer)
        XCTAssertEqual(character.mood, .thoughtful)
    }

    func testMoodColor() throws {
        let character = StrangerCharacter(
            id: "1", name: "Test", archetype: .wanderer, mood: .excited,
            backstory: "", avatarSymbol: "star", glowColor: "#FFD93D"
        )
        XCTAssertEqual(character.moodColor, "#FFD93D")
    }

    func testSampleCharactersNotEmpty() throws {
        let characters = StrangerCharacter.sampleCharacters
        XCTAssertFalse(characters.isEmpty)
        XCTAssertGreaterThanOrEqual(characters.count, 3)
    }

    func testAllArchetypesUnique() throws {
        let archetypes = StrangerCharacter.Archetype.allCases
        let uniqueArchetypes = Set(archetypes)
        XCTAssertEqual(archetypes.count, uniqueArchetypes.count)
    }
}