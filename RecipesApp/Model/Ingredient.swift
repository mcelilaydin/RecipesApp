//
//  Ingredient.swift
//  RecipesApp
//
//  Created by Celil Aydın on 6.07.2022.
//

import Foundation

struct Ingredients : Codable {
    let ingredients: [Ingredient]
}

struct Ingredient : Codable {
    let image, name: String
}
