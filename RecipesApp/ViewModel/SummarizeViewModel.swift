//
//  SummarizeViewModel.swift
//  RecipesApp
//
//  Created by Celil Aydın on 19.07.2022.
//

import Foundation

struct SummarizeViewModel{
    private var summarys : Summary
}

extension SummarizeViewModel {
    init(_ summary : Summary){
        self.summarys = summary
    }
}

extension SummarizeViewModel {
    var id : Int? {
        return summarys.id
    }
    var summary : String? {
        return summarys.summary
    }
    var title : String?{
        return summarys.title
    }
}
