//
//  ViewConstants.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import Foundation
import UIKit.UIColor

// MARK: - ViewConstants
enum ViewConstants {
    // MARK: - UIColor
    static let customBackgroundColor = UIColor(named: "BackgroundColor")
    
    
    // MARK: - UIRefreshButton
    static let customRefreshButtonWidth = 48
    static let customRefreshButtonHeight = 48
    static let customRefreshButtonCornerRadius = 24
    
    static let customRefreshButtonImageName = "arrow.clockwise"
    static let customRefreshButtonTopConstant = 48
    static let customRefreshButtonLeftConstant = 16
    
    
    // MARK: - UILabels
    // Title Label
    static let titleLabelFontSize = 24
    static let titleLabelTopConst = 18
    static let titleLabelHeightConst = 29
    static let titleLabelLeadingConst = 30
    static let titleLabelTrailingConst = -30
    
    // Feature Labels
    static let featureTitleLabelFontSize = 21
    static let featureHPTitleName = "hp"
    static let featureATTACKTitleName = "attack"
    static let featureDEFENSETitleName = "defense"
    static let featurePointLabelFontSize = 32
    
    static let hpTitleLabelTopConst = 101
    static let hpTitleLabelLeadingConst = 18
    static let hpTitleLabelHeightConst = 21
    
    static let defenseTitleLabelTrailingConst = -18
    
    static let hpPointTitleLabelBottomConst = -23
    static let hpPointTitleLabelHeightConst = 38
    
    // Loading Label
    static let loadingLabelFontSize = 24
    static let loadingLabelText = "Loading..."
    
    // MARK: - UIImageView
    static let imageViewIphoneHeight = 160
    static let imageViewIphoneWidth = 214
    static let imageViewIpadHeight = 180
    static let imageViewIpadWidth = 400
    
    
    // MARK: - UICardView
    static let cardViewIpadWidthConst = 700
    static let cardViewIpadHeightConst = 480
    static let cardViewIphoneWidthConst = 300
    static let cardViewIphoneHeightConst = 480
    
    static let cardViewIphoneCornerRadius = 36
    static let cardViewIpadCornerRadius = 72
}


// MARK: - Enum UIUserInterfaceIdiom
enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

// MARK: - CardFlip Animation Type
enum FlipAnimationType {
    case transitionFlipFromTop
    case transitionFlipFromLeft
}
