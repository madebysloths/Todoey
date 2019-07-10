//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by James on 7/8/19.
//  Copyright © 2019 Made By Sloths. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController : UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
        saveItems()
        
    // Turn list checkmark on and off depending on state of cell.
        
        tableView.deselectRow(at : indexPath, animated: true)
        
    }
    
    //:MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen after the user clicks the add button item on our UI Alert
            
            
            
            let newItem = Item(context: self.context)
            newItem.name = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
           print(error)
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {

        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print(error)
        }
    }
}
