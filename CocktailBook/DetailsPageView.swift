//
//  DetailsPageView.swift
//  CocktailBook
//
//  Created by 515148076 on 06/01/25.
//

import SwiftUI

@available(iOS 15.0, *)
struct DetailsPageView: View {
    var cocktail: Cocktails
    @ObservedObject var viewModel: CocktailViewModel
    @State private var isFavorite = false
    
    @available(iOS 15.0, *)
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
    
            HStack(alignment: .top, spacing: 10, content: {
                Image(systemName: "clock")
                Text("\(cocktail.preparationMinutes) minutes")
                                   .font(.headline)
                                   .foregroundColor(.secondary)
            })
            
            Image(cocktail.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight:300)
            Text(cocktail.longDescription)
                .font(.body)
                .foregroundColor(.secondary)
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)

            ForEach(cocktail.ingredients ?? ["Example"], id: \.self) { ingredient in
                HStack {
                    Image(systemName: "play.fill")
                    Text(ingredient)
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle(cocktail.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleFavorite(cocktail: cocktail)
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .purple : .gray)
                }
            }
        }
    }
}
/*
 #Preview {
 if #available(iOS 15.0, *) {
 DetailsPageView(cocktail: Cocktails(id: "1", name: "Piña colada", type: "alcoholic", shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 1, imageName: "pinacolada"), viewModel: CocktailViewModel())
 } else {
 // Fallback on earlier versions
 }
 }
 */
