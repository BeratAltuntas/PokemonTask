//
//  HomeViewController.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var refreshButton: CustomUIButton!
    private var cardView: CustomUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        contentView = UIView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 890),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 890)
        ])
        
        contentView.backgroundColor = ViewConstants.customBackgroundColor
        scrollView.backgroundColor = ViewConstants.customBackgroundColor
    }
    
    private func setupView() {
        setupScrollView()
        createRefreshButton()
        createPokemonViewContainer()
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
        contentView.addSubview(refreshButton)
        
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstants.customRefreshButtonTopConstant.ToCGFloat()),
            refreshButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: ViewConstants.customRefreshButtonLeftConstant.ToCGFloat()),
            refreshButton.widthAnchor.constraint(equalToConstant: ViewConstants.customRefreshButtonWidth.ToCGFloat()),
            refreshButton.heightAnchor.constraint(equalToConstant: ViewConstants.customRefreshButtonHeight.ToCGFloat())
        ])
    }
    
    private func createPokemonViewContainer() {
        cardView = CustomUIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.cornerRadius = ViewConstants.customUIViewCornerRadius.ToCGFloat()
        cardView.backgroundColor = .white
        
        // CardView Shadow
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        cardView.layer.shadowOpacity = 2.5
        cardView.layer.shadowRadius = 3.5
        contentView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(lessThanOrEqualTo: refreshButton.bottomAnchor, constant: 86),
            cardView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            cardView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            cardView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -182),
        ])
        
    }
}
