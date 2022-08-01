//
//  Extension+String.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation

extension String {
    func UpperFirst()-> String {
        let first = self.first?.uppercased()
        let withOutFirstLetter = self.dropFirst()
        guard let returning = first else { return self }
        return returning + withOutFirstLetter
    }
}
