//
//  CategoryViewController.swift
//  Todoey
//
//  Created by James on 7/10/19.
//  Copyright © 2019 Made By Sloths. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController : UITableViewController {
    
    var listArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }

    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        //tableView.deselectRow(at : indexPath, animated : true)
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier : "CategoryCell", for : indexPath)
        let category = listArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    // MARK: - Data Manipulation Methods
    @IBAction func addButtonPressed(_ sender : UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title : "New Category", message: "", preferredStyle : .alert)
        let action = UIAlertAction(title : "Add", style: .default) { (action) in
            
            let newCategory = Category(context : self.context)
            newCategory.name = textField.text!
            self.listArray.append(newCategory)
            self.saveData()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            textField = alertTextField
        }
        
        present(alert, animated : true)
    
    }
    
    func loadData() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            listArray = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print(indexPath)
            destinationVC.selectedCategory = listArray[indexPath.row]
        }
    }
}
