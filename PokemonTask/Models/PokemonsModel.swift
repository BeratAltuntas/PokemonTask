//
//  PokemonsModel.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation

struct PokemonsModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonsResult]?
}

// MARK: - Result
struct PokemonsResult: Codable {
    let name: String?
    let url: String?
}
