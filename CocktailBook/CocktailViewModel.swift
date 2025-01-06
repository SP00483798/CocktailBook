//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by 515148076 on 06/01/25.
//

import Foundation
import Combine

enum FilterState {
    case all
    case alcoholic
    case nonAlcoholic
}

class CocktailViewModel: ObservableObject {
    
    @Published var cocktails: [Cocktails] = []
    @Published var filteredCocktails: [Cocktails] = []
    @Published var errorMessage: String? = nil
    @Published var filterState: FilterState = .all {
            didSet { applyFilter() }
        }
    @Published var favorites: Set<String> = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let api: CocktailsAPI
    
    init(api: CocktailsAPI = FakeCocktailsAPI(withFailure: .count(3))) {
        self.api = api
        fetchMyCocktails()
    }
    
    func fetchMyCocktails() {
        api.cocktailsPublisher
            .decode(type: [Cocktails].self, decoder: JSONDecoder())
            .map { $0.sorted { $0.id < $1.id } } // Sort id
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    debugPrint(error.localizedDescription)
                    self?.errorMessage = error.localizedDescription
                    self?.retryFetchCocktails()
                }
            }, receiveValue: { [weak self] cocktails in
                self?.cocktails = cocktails
                self?.applyFilter()
            })
            .store(in: &cancellables)
    }
    
    func retryFetchCocktails() {
        fetchMyCocktails()
    }
    
    func applyFilter() {
        switch filterState {
        case .all:
            filteredCocktails = cocktails
        case .alcoholic:
            filteredCocktails = cocktails.filter { !$0.isAlcoholicBool }
        case .nonAlcoholic:
            filteredCocktails = cocktails.filter { $0.isAlcoholicBool }
        }
        print(filteredCocktails.count)
    }
    
    func toggleFavorite(cocktail: Cocktails) {
        if favorites.contains(cocktail.id) {
            favorites.remove(cocktail.id)
        } else {
            favorites.insert(cocktail.id)
        }
    }

    func isFavorite(cocktail: Cocktails) -> Bool {
        return favorites.contains(cocktail.id)
    }
}
