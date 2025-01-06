//
//  Cocktails.swift
//  CocktailBook
//
//  Created by 515148076 on 06/01/25.
//

import Foundation

struct Cocktails: Identifiable, Codable {
    
    var id: String
    var name: String
    var type: String
    var shortDescription: String
    var longDescription: String
    var preparationMinutes: Int
    var imageName: String
    var ingredients: [String]?
    
    var isAlcoholicBool: Bool {
        return type.lowercased().contains("non-alcoholic")
    }
}
