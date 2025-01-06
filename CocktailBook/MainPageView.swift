//
//  MainPageView.swift
//  CocktailBook
//
//  Created by 515148076 on 05/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
struct MainPageView: View {
    @StateObject private var viewModel = CocktailViewModel()
    @State private var favoriteCocktails: Set<String> = []
    
    @available(iOS 15.0, *)
    var body: some View {
        NavigationView {
            VStack {
                // Filter Toggle
                Picker("Filter", selection: $viewModel.filterState) {
                    Text("All").tag(FilterState.all)
                    Text("Alcoholic").tag(FilterState.alcoholic)
                    Text("Non-Alcoholic").tag(FilterState.nonAlcoholic)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List($viewModel.filteredCocktails){ cocktail in
                    NavigationLink(destination: DetailsPageView(cocktail: cocktail.wrappedValue, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            if viewModel.isFavorite(cocktail: cocktail.wrappedValue) {
                                HStack(content: {
                                    Text(cocktail.name.wrappedValue)
                                        .foregroundStyle(.purple)
                                        .font(.system(size: 30))
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.purple)
                                })
                            }else{
                                Text(cocktail.name.wrappedValue)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 30))
                            }
                            Text(cocktail.shortDescription.wrappedValue)
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(.plain) // Removes default list style appearance
            }
            .navigationTitle(navigationTitle)
        }
    }
    
//    private func toggleFavorite(cocktail: Cocktails) {
//            if favoriteCocktails.contains(cocktail.id) {
//                favoriteCocktails.remove(cocktail.id)
//            } else {
//                favoriteCocktails.insert(cocktail.id)
//            }
//        }
    
    private var navigationTitle: String {
            switch viewModel.filterState {
            case .all:
                return "All Cocktails"
            case .alcoholic:
                return "Alcoholic Cocktails"
            case .nonAlcoholic:
                return "Non-Alcoholic Cocktails"
            }
    }
}
/*
 #Preview {
 if #available(iOS 15.0, *) {
 MainPageView()
 } else {
 // Fallback on earlier versions
 }
 }
 */
