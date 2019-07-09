//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by James on 7/8/19.
//  Copyright © 2019 Made By Sloths. All rights reserved.
//

import UIKit

class ToDoListViewController : UITableViewController {
    
    let itemArray = ["Apple", "Butt Bars", "Blank Panties"]
    
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
}
