//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Hussein Qabalan on 4/10/20.
//  Copyright © 2020 Hussein Qabalan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Exercise"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Eat Breakfast"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Study"
        itemArray.append(newItem3)
        
        loadItems()
    }
    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
    }
    
    
    
    // MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (alertAction) in
            print("Item added successfully")
            let theText = textField.text!
            if !theText.isEmpty{
                self.itemArray.append(Item(title: theText, done: false))
                //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                
                self.saveItems()
            } else {
                alert.title = "Please Write Something to add item"
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Model Manipulation Methods
    
    func saveItems() {
         let encoder = PropertyListEncoder()
           do {
             let data = try encoder.encode(itemArray)
              try data.write(to: dataFilePath!)
           }
           catch {
                  print("Error encoding item array, \(error)")
             }
          self.tableView.reloadData()
    }
    
    func loadItems() {
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                itemArray = try decoder.decode([Item].self, from: data)
            }
        } catch {
            print("Error decoding item array \(error)")
        }
        
    }
    
}

