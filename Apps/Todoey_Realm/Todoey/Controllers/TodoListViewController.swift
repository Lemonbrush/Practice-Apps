//
//  ViewController.swift
//  Todoey
//
//  Created by Александр on 11.03.2021.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    var selectedCategory: Category? {
        // It happens after this variable initialization
        didSet {
           // loadItems()
        }
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The path to the local directory on the device to store App data
       //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //loadItems()
    }
    
    // MARK: IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoe Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //It will happen once the user hits the button
            
            /*
            let newItem = Item(context: self.context) // Automatically generated class by CoreData
            newItem.title = textField.text ?? "???"
            newItem.isDone = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
 
 */
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
            //context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            
            saveItems()
        }
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Tick the cell
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        saveItems() // And save to the local directory on the device
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
            //try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
         
    }
    /*
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        // Load Items which contain in a specific category
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        // If additional predicate (from search bar) exists add it to the request predicat array
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            itemArray = try context.fetch(request) // Save the data into itemArray
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    */
}

/*
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest() // Specify data type to search for
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) // specify query
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems() // Refresh table from scratch
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
*/
