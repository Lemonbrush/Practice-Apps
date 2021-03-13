//
//  ViewController.swift
//  Todoey
//
//  Created by Александр on 11.03.2021.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    // CoreData container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Item]()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The path to the local directory on the device to store App data
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
    }
    
    // MARK: IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoe Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //It will happen once the user hits the button
            
            let newItem = Item(context: self.context) // Automatically generated class by CoreData
            newItem.title = textField.text ?? "???"
            newItem.isDone = false
            
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Tick/Untick logic
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    // Cell editing
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            
            saveItems()
        }
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Tick the cell
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        saveItems() // And save to the local directory on the device
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Model Manipulation Methods
    
    // Encode data
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
         
    }
    
    // Decode data
    func loadItems() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest() // Specify data type to make a request
        
        do {
            itemArray = try context.fetch(request) // Save the data into itemArray
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }
 
}

