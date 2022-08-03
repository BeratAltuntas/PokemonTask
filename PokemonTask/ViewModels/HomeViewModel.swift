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
    func hideLoadingLabel()
    func showLoadingLabel()
    func flipCardView()
}

// MARK: - HomeViewModel
final class HomeViewModel {
    typealias CompletionOnlySuccess = (_ success: Bool)-> Void
    weak var delegate: HomeViewModelDelegate!
    var pokemonCount: Int?
    var pokemon: Pokemon!
    
    private func fetchPokemonCount(completion: @escaping CompletionOnlySuccess) {
        // returning pokemon count
        URLSessionManager.shared.FetchData(endPoint: DataEndPoints.getPokemons, type: PokemonsModel?.self) { [weak self ] result in
            switch result {
            case .success(let response):
                guard let count = response.count else { return }
                self?.pokemonCount = count
                completion(true)
            case .failure(let error):
                print(error)
                print("fetch poke count bum")
                completion(false)
            }
        }
    }
    
    private func fetchRandomPokemon(completion: @escaping CompletionOnlySuccess) {
        guard let pokeCount = pokemonCount else { return }
        
        let randomPoke = Int.random(in: 1...pokeCount)
        let endPoint = DataEndPoints.getPokemons + DataEndPoints.forwardSlash + randomPoke.ToString()
        URLSessionManager.shared.FetchData(endPoint: endPoint, type: Pokemon?.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.pokemon = response
                print(response)
                self?.delegate.updatePokemonFatures()
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    private func getImage(completion: @escaping CompletionOnlySuccess) {
        if pokemonCount != -1 {
            guard let imageUrlString = pokemon.sprites?.front_default else { return }
            let url = URL(string: imageUrlString)!
            URLSessionManager.shared.downloadImage(url: url) { [weak self] success, response in
                if success {
                    self?.delegate.loadImage(image: response)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}

// MARK: - Extension: HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    func loadViewAttiributes() {
        fetchPokemonCount { [weak self] success in
            if success {
                self?.delegate.showLoadingLabel()
                self?.fetchNewRandomPokemon()
            } else {
                self?.loadViewAttiributes()
            }
        }
    }
    
    func fetchNewRandomPokemon() {
        fetchRandomPokemon { [weak self] success in
            if success {
                self?.getPokemonImage()
            } else {
                self?.fetchNewRandomPokemon()
            }
        }
    }
    
    func getPokemonImage() {
        getImage { [weak self] success in
            if success {
                self?.delegate.flipCardView()
                self?.delegate.hideLoadingLabel()
            }
        }
    }
}
