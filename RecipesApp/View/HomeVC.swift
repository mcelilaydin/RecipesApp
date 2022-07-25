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
    
    @IBOutlet var spinner : UIActivityIndicatorView!
    
    let searchController = UISearchController()
    
    var text = ""
    
    var data = Data()
    
    let seconds = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.spinner.startAnimating()
        tableView.dataSource = self
        tableView.delegate = self
        title = "Recipes"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        setUp()
        self.spinner.hidesWhenStopped = true
    }
    
    func setUp(){
         
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch") ?? nil else { return }
        
        WebServices().searchRecipes(url: url, query: text ?? "") { recipes in
            self.recipeListVM = RecipeListViewModel(recipes: recipes)
            self.tableView.isHidden = true
            DispatchQueue.main.async {
                self.spinner.startAnimating()
               
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.spinner.stopAnimating()
            }
        }
    }

}

extension HomeVC : UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.isHidden = true
        text = searchController.searchBar.text ?? ""
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
           
            self.spinner.startAnimating()
            self.setUp()
            self.tableView.isHidden = false
        }
        
        self.spinner.stopAnimating()
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
    
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
           // print("this is the last cell")
           // let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
        //    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }*/
    
   
}
