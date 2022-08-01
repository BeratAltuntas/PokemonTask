//
//  Pokemon.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let id: Int?
    let name: String?
    let baseExperience: Int?
    let height: Int?
    let stats: [Stat]?
    let sprites: Sprites?
}

// MARK: - Species
struct Species: Codable {
    let name, url: String?
}
// MARK: - Stat
struct Stat: Codable {
    let base_stat: Int!
    let effort: Int?
    let stat: Species?
}

struct Sprites: Codable {
    let front_default: String?
    let other: Other?
}

// MARK: - Home
struct Home: Codable {
    let front_default: String?
}

// MARK: - Other
struct Other: Codable {
    let home: Home?
}

