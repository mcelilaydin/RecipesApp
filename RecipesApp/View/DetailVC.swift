//
//  DetailVC.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import Foundation
import UIKit
import CoreData

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var nutritionVM : NutritionViewModel!
    private var summarizeVM : SummarizeViewModel!
    
    var data = Data()
    
    var detailData : Resultt?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
    }
    
    func setUp(){
       
        guard let nutritionUrl = URL(string:"https://api.spoonacular.com/recipes/\(detailData?.id ?? 0)/nutritionWidget.json") ?? nil else { return }
        
        guard let summarizeUrl = URL(string: "https://api.spoonacular.com/recipes/\(detailData?.id ?? 0)/summary") ?? nil else { return }
        
        WebServices().nutritionID(url: nutritionUrl, id: detailData!.id) { nutrition in
            
            WebServices().summarize(url: summarizeUrl, id: self.detailData!.id) { summary in
                
            self.nutritionVM = NutritionViewModel(nutrition)
            self.summarizeVM = SummarizeViewModel(summary)
                
            DispatchQueue.main.async {
                self.proteinLabel.text = "Protein\n\(self.nutritionVM.protein ?? "")"
                self.fatLabel.text = "Fat\n\(self.nutritionVM.fat ?? "")"
                self.caloriesLabel.text = "Calories\n\(self.nutritionVM.calories ?? "")"
                self.carbsLabel.text = "Carbs\n\(self.nutritionVM.carbs ?? "")"
                
                //MARK: HTML PARSE
                let htmlString = self.summarizeVM.summary ?? ""
                let data = htmlString.data(using: .utf8)
                let  attributedString = try? NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                    self.summaryLabel.attributedText = attributedString
                
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

    @IBAction func favoriteButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            
        let newFavorite = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
        
        newFavorite.setValue(summarizeVM.title, forKey: "name")
        
        if let title = summarizeVM.title {
            newFavorite.setValue(title, forKey: "name")
        }
        
        newFavorite.setValue(summarizeVM.id, forKey: "id")
        
        
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
    }
    
}
