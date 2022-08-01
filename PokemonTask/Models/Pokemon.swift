//
//  Pokemon.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation

// MARK: - Pokemon
struct Pokemon {
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let heldItems: [Any?]?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let pastTypes: [Any?]?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?
}

// MARK: - Ability
struct Ability {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?
}

// MARK: - Species
struct Species {
    let name: String?
    let url: String?
}

// MARK: - GameIndex
struct GameIndex {
    let gameIndex: Int?
    let version: Species?
}

// MARK: - Move
struct Move {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?
}

// MARK: - GenerationV
struct GenerationV {
    let blackWhite: Sprites?
}

// MARK: - GenerationIv
struct GenerationIv {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites?
}

// MARK: - Versions
struct Versions {
    let generationI: GenerationI?
    let generationIi: GenerationIi?
    let generationIii: GenerationIii?
    let generationIv: GenerationIv?
    let generationV: GenerationV?
    let generationVi: [String: Home]?
    let generationVii: GenerationVii?
    let generationViii: GenerationViii?
}

// MARK: - Sprites
class Sprites {
    let backDefault: String?
    let backFemale: NSNull?
    let backShiny: String?
    let backShinyFemale: NSNull?
    let frontDefault: String?
    let frontFemale: NSNull?
    let frontShiny: String?
    let frontShinyFemale: NSNull?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?
    
    init(backDefault: String?, backFemale: NSNull?, backShiny: String?, backShinyFemale: NSNull?, frontDefault: String?, frontFemale: NSNull?, frontShiny: String?, frontShinyFemale: NSNull?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

// MARK: - GenerationI
struct GenerationI {
    let redBlue, yellow: RedBlue?
}

// MARK: - RedBlue
struct RedBlue {
    let backDefault, backGray, backTransparent, frontDefault: String?
    let frontGray, frontTransparent: String?
}

// MARK: - GenerationIi
struct GenerationIi {
    let crystal: Crystal?
    let gold, silver: Gold?
}

// MARK: - Crystal
struct Crystal {
    let backDefault, backShiny, backShinyTransparent, backTransparent: String?
    let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String?
}

// MARK: - Gold
struct Gold {
    let backDefault, backShiny, frontDefault, frontShiny: String?
    let frontTransparent: String?
}

// MARK: - GenerationIii
struct GenerationIii {
    let emerald: Emerald?
    let fireredLeafgreen, rubySapphire: Gold?
}

// MARK: - Emerald
struct Emerald {
    let frontDefault, frontShiny: String?
}

// MARK: - Home
struct Home {
    let frontDefault: String?
    let frontFemale: NSNull?
    let frontShiny: String?
    let frontShinyFemale: NSNull?
}

// MARK: - GenerationVii
struct GenerationVii {
    let icons: DreamWorld?
    let ultraSunUltraMoon: Home?
}

// MARK: - DreamWorld
struct DreamWorld {
    let frontDefault: String?
    let frontFemale: NSNull?
}

// MARK: - GenerationViii
struct GenerationViii {
    let icons: DreamWorld?
}

// MARK: - Other
struct Other {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?
}

// MARK: - OfficialArtwork
struct OfficialArtwork {
    let frontDefault: String?
}

// MARK: - Stat
struct Stat {
    let baseStat, effort: Int?
    let stat: Species?
}

// MARK: - TypeElement
struct TypeElement {
    let slot: Int?
    let type: Species?
}

