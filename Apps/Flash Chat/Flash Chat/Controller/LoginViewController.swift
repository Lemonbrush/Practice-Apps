//
//  LoginViewController.swift
//  Flash Chat
//
//  Created by Александр on 25.02.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let password = passwordTextField.text {
        
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    
                    let alert = UIAlertController(title: "Oops", message: e.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        
    }
    
}
