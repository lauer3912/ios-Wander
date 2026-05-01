import Foundation

struct StrangerCharacter: Identifiable {
    let id: String
    let name: String
    let archetype: Archetype
    let mood: Mood
    let backstory: String
    let avatarSymbol: String
    let glowColor: String

    enum Archetype: String, CaseIterable {
        case wanderer = "The Wanderer"
        case lostPoet = "Lost Poet"
        case nightOwl = "Night Owl"
        case gentleGiant = "Gentle Giant"
        case starGazer = "Star Gazer"
        case wanderingSoul = "Wandering Soul"
        case midnightPhilosopher = "Midnight Philosopher"
        case silentDreamer = "Silent Dreamer"
    }

    enum Mood: String {
        case excited = "Excited"
        case thoughtful = "Thoughtful"
        case melancholy = "Melancholy"
        case playful = "Playful"
        case calm = "Calm"
    }

    var moodColor: String {
        switch mood {
        case .excited: return "#FFD93D"
        case .thoughtful: return "#8B7FD3"
        case .melancholy: return "#6C8EBF"
        case .playful: return "#FF6B6B"
        case .calm: return "#4ECDC4"
        }
    }

    var moodIcon: String {
        switch mood {
        case .excited: return "sparkles"
        case .thoughtful: return "brain.head.profile"
        case .melancholy: return "cloud.rain"
        case .playful: return "face.smiling"
        case .calm: return "leaf"
        }
    }

    static var sampleCharacters: [StrangerCharacter] {
        [
            StrangerCharacter(id: "1", name: "Elowen", archetype: .wanderer, mood: .thoughtful,
                              backstory: "Has traveled through 47 cities but never found what she's looking for.",
                              avatarSymbol: "figure.walk", glowColor: "#8B7FD3"),
            StrangerCharacter(id: "2", name: "Kael", archetype: .lostPoet, mood: .melancholy,
                              backstory: "Writes poems that no one reads, about places no one visits.",
                              avatarSymbol: "pencil.and.outline", glowColor: "#6C8EBF"),
            StrangerCharacter(id: "3", name: "Orion", archetype: .nightOwl, mood: .calm,
                              backstory: " awake when the world sleeps, thinking thoughts too heavy for daylight.",
                              avatarSymbol: "moon.stars", glowColor: "#4ECDC4"),
            StrangerCharacter(id: "4", name: "Seraph", archetype: .starGazer, mood: .excited,
                              backstory: "Spends nights naming constellations that don't exist yet.",
                              avatarSymbol: "sparkle", glowColor: "#FFD93D"),
            StrangerCharacter(id: "5", name: "Rowan", archetype: .gentleGiant, mood: .calm,
                              backstory: "Speaks softly because the world is loud enough already.",
                              avatarSymbol: "tree", glowColor: "#4ECDC4"),
            StrangerCharacter(id: "6", name: "Luna", archetype: .wanderingSoul, mood: .playful,
                              backstory: "Collects laughter from strangers and trades it for stories.",
                              avatarSymbol: "wind", glowColor: "#FF6B6B")
        ]
    }
}