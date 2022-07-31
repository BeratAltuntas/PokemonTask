//
//  HomeViewController.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import UIKit
enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}


final class HomeViewController: UIViewController {
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var refreshButton: CustomUIButton!
    private var cardView: CustomUIView!
    private var titleLabel: UILabel!
    private var imageView: UIImageView!
    private var featureLabels: [UILabel]!
    private var screenSize: CGRect = UIScreen.main.bounds
    
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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: screenSize.height)
            //contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            //contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            
            
        ])
        
        contentView.backgroundColor = ViewConstants.customBackgroundColor
        scrollView.backgroundColor = ViewConstants.customBackgroundColor
    }
    
    private func setupView() {
        setupScrollView()
        createRefreshButton()
        createPokemonViewContainer()
        createPokemonTitleLabel()
        createPokemonImageView()
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
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 3.5)
        cardView.layer.shadowOpacity = 4.5
        cardView.layer.shadowRadius = 5.5
        contentView.addSubview(cardView)
        
        layoutConstraints()
        
    }
    
    private func createPokemonTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Balbasour" // pokemonModel.name
        titleLabel.font = .rounded(ofSize: 24, weight: .regular)
        titleLabel.tintColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30)
        ])
    }
    
    private func createPokemonImageView() {
        imageView = UIImageView()
        imageView.image = UIImage(systemName: "terminal.fill") // pokemon.image
        imageView.contentMode = .scaleToFill
        imageView.startAnimating()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 136),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 114),
            imageView.heightAnchor.constraint(equalToConstant: 114)
        ])
        
    }
    
    private func createPokemonFeatureLabels() {
        
    }
    
    private func layoutConstraints() {
        
        if .pad == UIDevice.current.userInterfaceIdiom {
            // ipad screen config
            NSLayoutConstraint.activate([
                scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
                scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
                
                
                contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                
            ])
        }
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardView.widthAnchor.constraint(equalToConstant: screenSize.width / 2 + 100),
            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: screenSize.height / 2)
        ])
        
        contentView.layoutIfNeeded()
        cardView.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        screenSize = UIScreen.main.bounds
        layoutConstraints()
    }
}
