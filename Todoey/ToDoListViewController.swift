//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by James on 7/8/19.
//  Copyright © 2019 Made By Sloths. All rights reserved.
//

import UIKit

class ToDoListViewController : UITableViewController {
    
    var itemArray = ["Apple", "Butt Bars", "Blank Panties"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
    
    // Turn list checkmark on and off depending on state of cell.
        if tableView.cellForRow(at : indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at : indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at : indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at : indexPath, animated: true)
        
    }
    
    //:MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen after the user clicks the add button item on our UI Alert
            self.itemArray.append(textField.text!)
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
