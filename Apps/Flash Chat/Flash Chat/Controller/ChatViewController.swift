//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Александр on 25.02.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Top bar menu setup 
        navigationItem.hidesBackButton = true
        navigationItem.title = "⚡️FlashChat"
    }

    @IBAction func sendPressed(_ sender: Any) {
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}
