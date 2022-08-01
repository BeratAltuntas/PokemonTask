//
//  PokemonsModel.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation

struct Pokemons {
    let count: Int?
    let next: String?
    let previous: NSNull?
    let results: [Result]?
}

// MARK: - Result
struct Result {
    let name: String?
    let url: String?
}
