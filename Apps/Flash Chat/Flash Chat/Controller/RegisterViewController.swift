//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Александр on 25.02.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextField.text {
        
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error
                {
                    // localizedDescription boils down the error text so you can use it to show to user
                    let errorText = e.localizedDescription
                    
                    // Alert view shows to user in case of an error
                    let alert = UIAlertController(title: "Ooops", message: errorText, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    // Navigate to the Chat

                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
            
        }
    }
    
}
