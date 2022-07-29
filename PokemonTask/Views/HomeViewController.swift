//
//  HomeViewController.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    private var refreshButton: CustomUIButton!
    private var cardView: CustomUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = ViewConstants.customBackgroundColor
        createRefreshButton()
    }
    
    private func createRefreshButton() {
        refreshButton = CustomUIButton()
        
        // Button Shadow
        refreshButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        refreshButton.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        refreshButton.layer.shadowOpacity = 1.5
        refreshButton.layer.shadowRadius = 1.5
        
        // Button View Specs
        refreshButton.cornerRadius = ViewConstants.customRefreshButtonCornerRadius.ToCGFloat()
        refreshButton.backgroundColor = .white
        refreshButton.tintColor = ViewConstants.customBackgroundColor
        refreshButton.setImage(UIImage(systemName: ViewConstants.customRefreshButtonImageName), for: .normal)
        refreshButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(font: .rounded(ofSize: 24, weight: .black)), forImageIn: .normal)
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewConstants.customRefreshButtonTopConstant.ToCGFloat()),
            refreshButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.customRefreshButtonLeftConstant.ToCGFloat()),
            refreshButton.widthAnchor.constraint(equalToConstant: ViewConstants.customRefreshButtonWidth.ToCGFloat()),
            refreshButton.heightAnchor.constraint(equalToConstant: ViewConstants.customRefreshButtonHeight.ToCGFloat())
        ])
    }
    
    private func createView() {
        cardView = CustomUIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.cornerRadius = ViewConstants.customUIViewCornerRadius.ToCGFloat()
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            
        ])
        
    }
}
