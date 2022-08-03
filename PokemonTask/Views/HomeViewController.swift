//
//  HomeViewController.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 29.07.2022.
//

import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }

    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var refreshButton: CustomUIButton!
    private var cardView: CustomUIView!
    private var pokemonNameTitleLabel: UILabel!
    private var pokemonImageView: UIImageView!
    
    private var hpTitleLabel: UILabel!
    private var hpPointTitleLabel: UILabel!
    
    private var attackTitleLabel: UILabel!
    private var attackPointTitleLabel: UILabel!
    
    private var defenseTitleLabel: UILabel!
    private var defensePointTitleLabel: UILabel!
    
    private var loadingLabel: CustomUILabel!
    
    private var currentFlipType: FlipAnimationType = .transitionFlipFromLeft
    private var screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vm = HomeViewModel()
        viewModel = vm
        setupView()
        showLoadingLabel()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        screenSize = UIScreen.main.bounds
        layoutConstraints()
    }
    
    // MARK: setupScrollView
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
    
    // MARK: setupView
    private func setupView() {
        viewModel.loadViewAttiributes()
        setupScrollView()
        createRefreshButton()
        createPokemonCardView()
        createPokemonTitleLabel()
        createLoadingLabel()
        createPokemonImageView()
        createPokemonFeatureLabels()
    }
    
    // MARK: createRefreshButton
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
        
        refreshButton.addTarget(self, action: #selector(getNewPokemon), for: .touchUpInside)
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(refreshButton)
        
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstants.customRefreshButtonTopConstant.ToCGFloat()),
            refreshButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: ViewConstants.customRefreshButtonLeftConstant.ToCGFloat()),
            refreshButton.widthAnchor.constraint(equalToConstant: ViewConstants.customRefreshButtonWidth.ToCGFloat()),
            refreshButton.heightAnchor.constraint(equalToConstant: ViewConstants.customRefreshButtonHeight.ToCGFloat())
        ])
    }
    
    // MARK: createPokemonCardView
    private func createPokemonCardView() {
        cardView = CustomUIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.cornerRadius = UIDevice.current.userInterfaceIdiom == .phone ? ViewConstants.cardViewIphoneCornerRadius.ToCGFloat() : ViewConstants.cardViewIpadCornerRadius.ToCGFloat()
        cardView.backgroundColor = .white
        
        // CardView Shadow
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 3.5)
        cardView.layer.shadowOpacity = 4.5
        cardView.layer.shadowRadius = 5.5
        contentView.addSubview(cardView)
        layoutConstraints()
    }
    
    // MARK: createPokemonTitleLabel
    private func createPokemonTitleLabel() {
        pokemonNameTitleLabel = UILabel()
        pokemonNameTitleLabel.text = "" // pokemonModel.name
        pokemonNameTitleLabel.font = .rounded(ofSize: ViewConstants.titleLabelFontSize.ToCGFloat(), weight: .regular)
        pokemonNameTitleLabel.tintColor = .black
        pokemonNameTitleLabel.textAlignment = .center
        pokemonNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(pokemonNameTitleLabel)
        
        NSLayoutConstraint.activate([
            pokemonNameTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: ViewConstants.titleLabelTopConst.ToCGFloat()),
            pokemonNameTitleLabel.heightAnchor.constraint(equalToConstant: ViewConstants.titleLabelHeightConst.ToCGFloat()),
            pokemonNameTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: ViewConstants.titleLabelLeadingConst.ToCGFloat()),
            pokemonNameTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: ViewConstants.titleLabelTrailingConst.ToCGFloat())
        ])
    }
    
    
    // MARK: createPokemonImageView
    private func createPokemonImageView() {
        pokemonImageView = UIImageView()
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.startAnimating()
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(pokemonImageView)
        let imageViewHeight = UIDevice.current.userInterfaceIdiom == .phone ? ViewConstants.imageViewIphoneHeight : ViewConstants.imageViewIpadHeight
        let imageViewWidth = UIDevice.current.userInterfaceIdiom == .phone ? ViewConstants.imageViewIphoneWidth : ViewConstants.imageViewIpadWidth
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            pokemonImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: imageViewHeight.ToCGFloat()),
            pokemonImageView.widthAnchor.constraint(equalToConstant: imageViewWidth.ToCGFloat())
        ])
    }
    
    // MARK: createLoadingLabel
    private func createLoadingLabel() {
        loadingLabel = CustomUILabel()
        loadingLabel.text = ViewConstants.loadingLabelText // loading
        loadingLabel.font = .rounded(ofSize: ViewConstants.loadingLabelFontSize.ToCGFloat(), weight: .regular)
        loadingLabel.isHidden = false
        loadingLabel.layer.masksToBounds = true
        loadingLabel.cornerRadius = ViewConstants.cardViewIpadCornerRadius.ToCGFloat()
        loadingLabel.layer.zPosition = 10
        loadingLabel.backgroundColor = .white
        loadingLabel.tintColor = .black
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            loadingLabel.heightAnchor.constraint(equalTo: cardView.heightAnchor),
            loadingLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor)
        ])
        
    }
    
    // MARK: createPokemonFeatureLabels
    private func createPokemonFeatureLabels() {
        // hp Labels
        hpTitleLabel = UILabel()
        hpTitleLabel.text = ViewConstants.featureHPTitleName // hp
        hpTitleLabel.font = .rounded(ofSize: ViewConstants.featureTitleLabelFontSize.ToCGFloat(), weight: .regular)
        hpTitleLabel.tintColor = .black
        hpTitleLabel.textAlignment = .center
        hpTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(hpTitleLabel)
        
        hpPointTitleLabel = UILabel()
        hpPointTitleLabel.text = "" // hp point
        hpPointTitleLabel.font = .rounded(ofSize: ViewConstants.featurePointLabelFontSize.ToCGFloat(), weight: .medium)
        hpPointTitleLabel.tintColor = .black
        hpPointTitleLabel.textAlignment = .center
        hpPointTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(hpPointTitleLabel)
        
        
        
        // attack Labels
        attackTitleLabel = UILabel()
        attackTitleLabel.text = ViewConstants.featureATTACKTitleName // attack
        attackTitleLabel.font = .rounded(ofSize: ViewConstants.featureTitleLabelFontSize.ToCGFloat(), weight: .regular)
        attackTitleLabel.tintColor = .black
        attackTitleLabel.textAlignment = .center
        attackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(attackTitleLabel)
        
        attackPointTitleLabel = UILabel()
        attackPointTitleLabel.text = "" // attack point
        attackPointTitleLabel.font = .rounded(ofSize: ViewConstants.featurePointLabelFontSize.ToCGFloat(), weight: .medium)
        attackPointTitleLabel.tintColor = .black
        attackPointTitleLabel.textAlignment = .center
        attackPointTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(attackPointTitleLabel)
        
        
        //defense Labels
        defenseTitleLabel = UILabel()
        defenseTitleLabel.text = ViewConstants.featureDEFENSETitleName // defense
        defenseTitleLabel.font = .rounded(ofSize: ViewConstants.featureTitleLabelFontSize.ToCGFloat(), weight: .regular)
        defenseTitleLabel.tintColor = .black
        defenseTitleLabel.textAlignment = .center
        defenseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(defenseTitleLabel)
        
        defensePointTitleLabel = UILabel()
        defensePointTitleLabel.text = "" // defense point
        defensePointTitleLabel.font = .rounded(ofSize: ViewConstants.featurePointLabelFontSize.ToCGFloat(), weight: .medium)
        defensePointTitleLabel.tintColor = .black
        defensePointTitleLabel.textAlignment = .center
        defensePointTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(defensePointTitleLabel)
        
        let labelwidth = (((screenSize.width / 2 + 100) - 36) / 3)
        
        NSLayoutConstraint.activate([
            hpTitleLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: ViewConstants.hpTitleLabelTopConst.ToCGFloat()),
            hpTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: ViewConstants.hpTitleLabelLeadingConst.ToCGFloat()),
            hpTitleLabel.widthAnchor.constraint(equalToConstant: labelwidth),
            hpTitleLabel.heightAnchor.constraint(equalToConstant: ViewConstants.hpTitleLabelHeightConst.ToCGFloat()),
            
            attackTitleLabel.topAnchor.constraint(equalTo: hpTitleLabel.topAnchor),
            attackTitleLabel.bottomAnchor.constraint(equalTo: hpTitleLabel.bottomAnchor),
            attackTitleLabel.leadingAnchor.constraint(equalTo: hpTitleLabel.trailingAnchor),
            attackTitleLabel.widthAnchor.constraint(equalToConstant: labelwidth),
            
            
            defenseTitleLabel.topAnchor.constraint(equalTo: attackTitleLabel.topAnchor),
            defenseTitleLabel.bottomAnchor.constraint(equalTo: attackTitleLabel.bottomAnchor),
            defenseTitleLabel.leadingAnchor.constraint(equalTo: attackTitleLabel.trailingAnchor),
            defenseTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: ViewConstants.defenseTitleLabelTrailingConst.ToCGFloat()),
            defenseTitleLabel.widthAnchor.constraint(equalToConstant: labelwidth),
            
            
            hpPointTitleLabel.topAnchor.constraint(equalTo: hpTitleLabel.bottomAnchor),
            hpPointTitleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: ViewConstants.hpPointTitleLabelBottomConst.ToCGFloat()),
            hpPointTitleLabel.leadingAnchor.constraint(equalTo: hpTitleLabel.leadingAnchor),
            hpPointTitleLabel.trailingAnchor.constraint(equalTo: hpTitleLabel.trailingAnchor),
            hpPointTitleLabel.heightAnchor.constraint(equalToConstant:  ViewConstants.hpPointTitleLabelHeightConst.ToCGFloat()),
            
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
    
    // MARK: layoutConstraints
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
                cardView.widthAnchor.constraint(equalToConstant: ViewConstants.cardViewIpadWidthConst.ToCGFloat()),
                cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewConstants.cardViewIpadHeightConst.ToCGFloat())
            ])
        } else {
            // iphone Screen config
            NSLayoutConstraint.activate([
                // CardView Front
                cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                cardView.widthAnchor.constraint(equalToConstant: screenSize.width / 2 + 100),
                cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: screenSize.height / 2)
            ])
        }
        contentView.layoutIfNeeded()
        cardView.layoutIfNeeded()
    }
    
    @objc private func getNewPokemon() {
        showLoadingLabel()
        viewModel.fetchNewRandomPokemon()
    }
}

// MARK: - Extension- HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
    func updatePokemonFatures() {
        DispatchQueue.main.async {
            self.pokemonNameTitleLabel.text = self.viewModel.pokemon.name?.UpperFirst()
            self.hpPointTitleLabel.text = self.viewModel.pokemon.stats?[.hp].base_stat?.ToString()
            self.attackPointTitleLabel.text = self.viewModel.pokemon.stats?[.attack].base_stat?.ToString()
            self.defensePointTitleLabel.text = self.viewModel.pokemon.stats?[.defense].base_stat?.ToString()
        }
    }
    
    func loadImage(image: Any) {
        guard let img = image as? UIImage else { return }
        DispatchQueue.main.async {
            self.pokemonImageView.contentMode = .scaleAspectFill
            self.pokemonImageView.image = nil
            self.pokemonImageView.image = img
        }
    }
    
    func flipCardView() {
        DispatchQueue.main.async { [weak self] in
            var transationOpt: UIView.AnimationOptions
            switch self?.currentFlipType {
            case .transitionFlipFromTop:
                transationOpt = .transitionFlipFromTop
                self?.currentFlipType = .transitionFlipFromLeft
            case .transitionFlipFromLeft:
                transationOpt = .transitionFlipFromLeft
                self?.currentFlipType = .transitionFlipFromTop
            default:
                transationOpt = .transitionFlipFromLeft
            }
            
            UIView.transition(with: (self?.cardView)!, duration: 1.3, options: transationOpt) {
            } completion: { finished in
                if finished {
                    self?.hideLoadingLabel()
                }
            }
        }
    }
    
    func showLoadingLabel() {
        DispatchQueue.main.async {
            self.loadingLabel.isHidden = false
        }
    }
    
    func hideLoadingLabel() {
        DispatchQueue.main.async {
            self.loadingLabel.isHidden = true
        }
    }
}
