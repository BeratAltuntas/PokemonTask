//
//  Extension+View.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import Foundation
import UIKit

@IBDesignable
class CustomUIView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
