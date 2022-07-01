//
//  Recipe.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import Foundation

struct Recipes: Codable  {
    let results: [Resultt]
    let offset, number, totalResults: Int
}

struct Resultt: Codable {
    let id: Int
    let title: String
    let image: String
}
