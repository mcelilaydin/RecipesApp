//
//  WebServices.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import Foundation
import Alamofire


class WebServices{
    
    static var header: HTTPHeaders = [
        "x-api-key": "b5ba505c9aa54d9fa9e14fd2f815d328"
    ]
   
    func searchRecipes(url:URL,query:String,completion: @escaping ([Resultt]) -> ()) {
        
        let params = ["query" :  query]
        
        AF.request(url as URLConvertible, method: .get, parameters: params , encoder: URLEncodedFormParameterEncoder.default, headers: WebServices.header).response { response in
            
            if response.response?.statusCode != 200 {
                print("Status code is not 200")
            }
            
            let result = try? JSONDecoder().decode(Recipes.self, from: response.data!)
            
            if let result = result {
                completion(result.results)
            }
                
        }.resume()
    }
    
    func nutritionID(url:URL,id:Int,completion: @escaping (Nutritions) -> ()){
        
        let params = ["id" : id]
        
        AF.request(url as URLConvertible, method: .get, parameters: params , encoder: URLEncodedFormParameterEncoder.default, headers: WebServices.header).response { response in
            
            if response.response?.statusCode != 200 {
                print("Status code is not 200")
            }
            
            let result = try? JSONDecoder().decode(Nutritions.self, from: response.data!)
            
            if let result = result {
                completion(result)
            }
            
        }.resume()
    }
    
    func summarize(url: URL, id: Int, completion: @escaping (Summary) -> ()){
        
        let params = ["id" : id]
        
        AF.request(url as URLConvertible, method: .get, parameters: params , encoder: URLEncodedFormParameterEncoder.default, headers: WebServices.header).response { response in
            
            if response.response?.statusCode != 200 {
                print("Status code is not 200")
            }
            
            let result = try? JSONDecoder().decode(Summary.self, from: response.data!)
            
            if let result = result {
                completion(result)
            }
            
        }.resume()
        
    }

    func ingredients(url:URL, id:Int,completion: @escaping ([Ingredient]) -> ()){
        
        let params = ["id" : id]
        
        AF.request(url as URLConvertible, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: WebServices.header).response { response in
           
            if response.response?.statusCode != 200 {
                print("Status code is not 200")
            }
            
            let result = try? JSONDecoder().decode(Ingredients.self, from: response.data!)
            
            if let result = result{
                completion(result.ingredients)
            }
            
        }.resume()
    }

}
