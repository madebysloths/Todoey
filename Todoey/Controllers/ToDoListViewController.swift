//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by James on 7/8/19.
//  Copyright © 2019 Made By Sloths. All rights reserved.
//

import UIKit

class ToDoListViewController : UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.name = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.name = "Kick Butt"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.name = "Chew Bubblegum"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
       
    }

    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
    
    // Turn list checkmark on and off depending on state of cell.
        
        tableView.deselectRow(at : indexPath, animated: true)
        
    }
    
    //:MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen after the user clicks the add button item on our UI Alert
            
            let newItem = Item()
            newItem.name = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}
