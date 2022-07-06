//
//  IngredientsViewModel.swift
//  RecipesApp
//
//  Created by Celil Aydın on 6.07.2022.
//

import Foundation

struct IgredientsViewModel {
    private var igredients : Ingredient
}

extension IgredientsViewModel {
    init(_ igredients : Ingredient){
        self.igredients = igredients
    }
}

extension IgredientsViewModel {
    
    var name : String? {
        return self.igredients.name
    }
    var image : String? {
        return self.igredients.image
    }
    
}
