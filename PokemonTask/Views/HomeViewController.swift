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
    
    private var hpTitleLabel: UILabel!
    private var hpPointTitleLabel: UILabel!
    
    private var attackTitleLabel: UILabel!
    private var attackPointTitleLabel: UILabel!
    
    private var defenseTitleLabel: UILabel!
    private var defensePointTitleLabel: UILabel!
    
    
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
        createPokemonFeatureLabels()
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
        cardView.cornerRadius = UIDevice.current.userInterfaceIdiom == .phone ? ViewConstants.customUIViewCornerRadius.ToCGFloat() : 72
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
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
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
        let imageViewHeight = UIDevice.current.userInterfaceIdiom == .phone ? 100 : 200
        
        NSLayoutConstraint.activate([
            //imageView.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 136),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight.ToCGFloat()),
            imageView.widthAnchor.constraint(equalToConstant: imageViewHeight.ToCGFloat())
        ])
        
    }
    
    private func createPokemonFeatureLabels() {
        // hp Labels
        hpTitleLabel = UILabel()
        hpTitleLabel.text = "hp" // hp
        hpTitleLabel.font = .rounded(ofSize: 21, weight: .regular)
        hpTitleLabel.tintColor = .black
        hpTitleLabel.textAlignment = .center
        hpTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(hpTitleLabel)
        
        hpPointTitleLabel = UILabel()
        hpPointTitleLabel.text = "45" // hp point
        hpPointTitleLabel.font = .rounded(ofSize: 32, weight: .medium)
        hpPointTitleLabel.tintColor = .black
        hpPointTitleLabel.textAlignment = .center
        hpPointTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(hpPointTitleLabel)
        
        
        
        // attack Labels
        attackTitleLabel = UILabel()
        attackTitleLabel.text = "attack" // attack
        attackTitleLabel.font = .rounded(ofSize: 21, weight: .regular)
        attackTitleLabel.tintColor = .black
        attackTitleLabel.textAlignment = .center
        attackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(attackTitleLabel)
        
        attackPointTitleLabel = UILabel()
        attackPointTitleLabel.text = "49" // attack point
        attackPointTitleLabel.font = .rounded(ofSize: 32, weight: .medium)
        attackPointTitleLabel.tintColor = .black
        attackPointTitleLabel.textAlignment = .center
        attackPointTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(attackPointTitleLabel)
        
        
        //defense Labels
        defenseTitleLabel = UILabel()
        defenseTitleLabel.text = "defense" // defense
        defenseTitleLabel.font = .rounded(ofSize: 21, weight: .regular)
        defenseTitleLabel.tintColor = .black
        defenseTitleLabel.textAlignment = .center
        defenseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(defenseTitleLabel)
        
        defensePointTitleLabel = UILabel()
        defensePointTitleLabel.text = "49" // defense point
        defensePointTitleLabel.font = .rounded(ofSize: 32, weight: .medium)
        defensePointTitleLabel.tintColor = .black
        defensePointTitleLabel.textAlignment = .center
        defensePointTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(defensePointTitleLabel)
        
        let labelwidth = (((screenSize.width / 2 + 100) - 36) / 3)
        NSLayoutConstraint.activate([
            hpTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 101),
            hpTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 18),
            hpTitleLabel.widthAnchor.constraint(equalToConstant: labelwidth),
            hpTitleLabel.heightAnchor.constraint(equalToConstant: 21),
            
            attackTitleLabel.topAnchor.constraint(equalTo: hpTitleLabel.topAnchor),
            attackTitleLabel.bottomAnchor.constraint(equalTo: hpTitleLabel.bottomAnchor),
            attackTitleLabel.leadingAnchor.constraint(equalTo: hpTitleLabel.trailingAnchor),
            attackTitleLabel.widthAnchor.constraint(equalToConstant: labelwidth),
            
            
            defenseTitleLabel.topAnchor.constraint(equalTo: attackTitleLabel.topAnchor),
            defenseTitleLabel.bottomAnchor.constraint(equalTo: attackTitleLabel.bottomAnchor),
            defenseTitleLabel.leadingAnchor.constraint(equalTo: attackTitleLabel.trailingAnchor),
            defenseTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),
            defenseTitleLabel.widthAnchor.constraint(equalToConstant: labelwidth),
            
            
            hpPointTitleLabel.topAnchor.constraint(equalTo: hpTitleLabel.bottomAnchor),
            hpPointTitleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -23),
            hpPointTitleLabel.leadingAnchor.constraint(equalTo: hpTitleLabel.leadingAnchor),
            hpPointTitleLabel.trailingAnchor.constraint(equalTo: hpTitleLabel.trailingAnchor),
            hpPointTitleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            attackPointTitleLabel.topAnchor.constraint(equalTo: hpPointTitleLabel.topAnchor),
            attackPointTitleLabel.bottomAnchor.constraint(equalTo: hpPointTitleLabel.bottomAnchor),
            attackPointTitleLabel.leadingAnchor.constraint(equalTo: attackTitleLabel.leadingAnchor),
            attackPointTitleLabel.trailingAnchor.constraint(equalTo: attackTitleLabel.trailingAnchor),
    
            
            defensePointTitleLabel.topAnchor.constraint(equalTo: hpPointTitleLabel.topAnchor),
            defensePointTitleLabel.bottomAnchor.constraint(equalTo: hpPointTitleLabel.bottomAnchor),
            defensePointTitleLabel.leadingAnchor.constraint(equalTo: defenseTitleLabel.leadingAnchor),
            defensePointTitleLabel.trailingAnchor.constraint(equalTo: defenseTitleLabel.trailingAnchor)
            
            
        ])
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
                contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                
                cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                cardView.widthAnchor.constraint(equalToConstant: 700),
                cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 480)
            ])
        } else {
            // iphone Screen config
            NSLayoutConstraint.activate([
                cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                cardView.widthAnchor.constraint(equalToConstant: screenSize.width / 2 + 100),
                cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: screenSize.height / 2)
            ])
        }
        
        
        
        contentView.layoutIfNeeded()
        cardView.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        screenSize = UIScreen.main.bounds
        layoutConstraints()
    }
}
