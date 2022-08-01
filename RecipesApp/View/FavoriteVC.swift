//
//  FavoriteVC.swift
//  RecipesApp
//
//  Created by Celil Aydın on 31.07.2022.
//

import UIKit
import CoreData

class FavoriteVC: UIViewController {

    @IBOutlet weak var favoriteTableview: UITableView!
    
    var nameArray = [String]()
    var idArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableview.dataSource = self
        favoriteTableview.delegate = self

        // Do any additional setup after loading the view.
        getCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Favorite"
        tabBarController?.navigationItem.searchController = nil
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCoreData), name: NSNotification.Name(rawValue: "newData"), object: nil)
        
     
    }
    
    @objc func getCoreData(){
    
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            
           let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
            
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? Int{
                    self.idArray.append(id)
                }
                
                self.favoriteTableview.reloadData()
                
                }
            }
        }catch{
            print("error")
        }
    }
}

extension FavoriteVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            
             let name = nameArray[indexPath.row]
            
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String{
                            if name == nameArray[indexPath.row] { // silecegimiz için tekrar emin olmak için
                                context.delete(result) // coredatadan sildi
                                nameArray.remove(at: indexPath.row) //array içinden arrayi sildik
                                idArray.remove(at: indexPath.row)
                                self.favoriteTableview.reloadData()
                                
                                do{
                                    try context.save()
                                }catch{
                                    print("error")
                                }
                                 
                                break
                                
                                }
                            }
                        }
                    }
                }catch{
                    print("error")
                }
        }
    }
}
