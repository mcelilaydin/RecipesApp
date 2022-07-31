//
//  FavoriteVC.swift
//  RecipesApp
//
//  Created by Celil Aydın on 31.07.2022.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var favoriteTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableview.dataSource = self
        favoriteTableview.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tabBarController?.title?.removeAll()
        tabBarController?.title = nil
        tabBarController?.navigationItem.searchController = nil
    }
}


extension FavoriteVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}
