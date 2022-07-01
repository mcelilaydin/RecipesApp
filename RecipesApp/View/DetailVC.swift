//
//  DetailVC.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    
    private var nutritionVM : NutritionViewModel!
    
    var data = Data()
    
    var detailData : Resultt?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp(){
       
        guard let url = URL(string:"https://api.spoonacular.com/recipes/\(detailData?.id ?? 0)/nutritionWidget.json") ?? nil else { return }
        
        WebServices().nutritionID(url: url, id: detailData!.id) { nutrition in
            self.nutritionVM = NutritionViewModel(nutrition)
            DispatchQueue.main.async {
                self.proteinLabel.text = "Protein\n\(self.nutritionVM.protein ?? "")"
                self.fatLabel.text = "Fat\n\(self.nutritionVM.fat ?? "")"
                self.caloriesLabel.text = "Calories\n\(self.nutritionVM.calories ?? "")"
                self.carbsLabel.text = "Carbs\n\(self.nutritionVM.carbs ?? "")"
                
                if let urlString = URL(string: self.detailData?.image ?? ""){
                    DispatchQueue.main.async {
                        do{
                            self.data = try Data(contentsOf: urlString)
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(data: self.data)
                            }
                        }catch{
                            print("ErrorImage")
                        }
                    }
                }
                
            }
        }
    }
    
    
}
