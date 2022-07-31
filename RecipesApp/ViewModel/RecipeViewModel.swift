//
//  RecipeViewModel.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import Foundation

struct RecipeListViewModel {
    
    var recipes : [Resultt]
    
}

extension RecipeListViewModel {
    
    var numberOfSection: Int {
        return recipes.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return recipes.count
    }
    
    func recipeAtIndex(_ index: Int) -> RecipeViewModel {
        
        let recipe = self.recipes[index]
        return RecipeViewModel(recipe)
        
    }
        
  //MARK: WillSelectRowAt viewmodel !
    
   // func selectRowAt(_ index: Int) -> Int{
   //     let recipe = self.recipes[index]
   //     return recipe.count
   // }
    
}


//MARK: -

struct RecipeViewModel {
    
    private let recipe : Resultt
    
}

extension RecipeViewModel {
    init(_ recipes : Resultt){
        self.recipe = recipes
    }
}

extension RecipeViewModel {
    
    var id : Int? {
        return self.recipe.id
    }
    
    var title : String? {
        return self.recipe.title
    }
    
    var image : String? {
        return self.recipe.image
    }
    
}
