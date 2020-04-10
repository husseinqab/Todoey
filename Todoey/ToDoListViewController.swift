//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Hussein Qabalan on 4/10/20.
//  Copyright © 2020 Hussein Qabalan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Exercise", "Eat Breakfast", "Watch a film"]

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //Mark - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    
    //Mark - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    

}

