//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Hussein Qabalan on 4/18/20.
//  Copyright © 2020 Hussein Qabalan. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadItems()

    }
    

    
    
    //MARK:- Tableview DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK:- Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ToDoListViewController {
            
            if let indexpath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryArray[indexpath.row]
            }
        }
    }
    
    //MARK:- Data Manipulation Methods
    
    func loadItems(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK:- Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create New Category"
            textField = alertTextFeild
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (alertAction) in
            
            let theText = textField.text!
            
            if !theText.isEmpty {
                let category = Category(context: self.context)
                category.name = theText
                // Important
                self.categoryArray.append(category)
                self.saveItems()
                print("Item Added Successfully")
            } else {
                alert.title = "Category Name Can't be empty"
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
      
    
}
