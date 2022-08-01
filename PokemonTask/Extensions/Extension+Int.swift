//
//  Extension+Int.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import Foundation
import UIKit

extension Int {
    static let hp = 0
    static let attack = 1
    static let defense = 2
    
    func ToCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func ToString()-> String {
        return String(self)
    }
}
