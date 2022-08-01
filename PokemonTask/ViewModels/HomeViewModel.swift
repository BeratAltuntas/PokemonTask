//
//  HomeViewModel.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate! { get }
    var pokemon: Pokemon! { get }
    
    func loadViewAttiributes()
    func fetchNewRandomPokemon()
    
}

// MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
    func updatePokemonFatures()
    func loadImage(image: Any)
    func hideElements()
    func unhideElements()
}

// MARK: - HomeViewModel
final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate!
    var pokemonCount: Int?
    var pokemon: Pokemon!
    
    private func fetchPokemonCount() {
        // returning pokemon count
        URLSessionManager.shared.FetchData(endPoint: DataEndPoints.getPokemons, type: PokemonsModel?.self) {[weak self ] result in
            switch result {
            case .success(let response):
                guard let count = response.count else { return }
                self?.pokemonCount = count
                self?.fetchRandomPokemon()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchRandomPokemon() {
        guard let pokeCount = pokemonCount else { return }
        
        let randomPoke = Int.random(in: 1...pokeCount)
        let endPoint = DataEndPoints.getPokemons + DataEndPoints.forwardSlash + randomPoke.ToString()
        
        URLSessionManager.shared.FetchData(endPoint: endPoint, type: Pokemon?.self) {[weak self ] result in
            switch result {
            case .success(let response):
                self?.pokemon = response
                self?.delegate.updatePokemonFatures()
                self?.getImage()
            case .failure(let error):
                print(error)
            }
        }
    }
    private func getImage() {
        if pokemonCount != -1 {
            guard let imageUrlString = pokemon.sprites?.front_default else { return }
            let url = URL(string: imageUrlString)!
            URLSessionManager.shared.downloadImage(url: url) {[weak self] success, response in
                if success {
                    self?.delegate.unhideElements()
                    self?.delegate.loadImage(image: response)
                }
            }
        }
    }
}

// MARK: - Extension: HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    func loadViewAttiributes() {
        fetchPokemonCount()
    }
    
    func fetchNewRandomPokemon() {
        fetchRandomPokemon()
    }
}
