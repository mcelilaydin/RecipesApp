//
//  ViewController.swift
//  RecipesApp
//
//  Created by Celil Aydın on 1.07.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    private var recipeListVM : RecipeListViewModel!

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    var text = ""
    
    var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        title = "Recipes"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        setUp()
    }
    
    func setUp(){
         
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch") ?? nil else { return }
        
        WebServices().searchRecipes(url: url, query: text ?? "") { recipes in
            self.recipeListVM = RecipeListViewModel(recipes: recipes)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension HomeVC : UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        text = searchController.searchBar.text ?? ""
        setUp()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.recipeListVM == nil ? 0 : self.recipeListVM.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecipeTableViewCell
        let recipeVM = recipeListVM.recipeAtIndex(indexPath.row)
        
        cell.titleLabel.text = recipeVM.title
        
        if let urlString = URL(string: recipeVM.image ?? ""){
            DispatchQueue.main.async {
                do{
                    self.data = try Data(contentsOf: urlString)
                    DispatchQueue.main.async {
                        cell.cellImageView.image = UIImage(data: self.data)
                    }
                }catch{
                    print("ErrorCellImage")
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailVC
        let recipesVM = recipeListVM.recipes
        vc?.detailData = recipesVM[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        return indexPath
    }
   
}
