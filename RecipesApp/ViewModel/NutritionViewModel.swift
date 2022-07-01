//
//  NutritionViewModel.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import Foundation

struct NutritionViewModel{
    private var nutrition : Nutritions
}

extension NutritionViewModel{
    init(_ nutritions : Nutritions){
        self.nutrition = nutritions
    }
}

extension NutritionViewModel{
    
    var calories : String? {
        return self.nutrition.calories
    }
    var carbs : String? {
        return self.nutrition.carbs
    }
    var fat : String? {
        return self.nutrition.fat
    }
    var protein: String? {
        return self.nutrition.protein
    }
    
}

