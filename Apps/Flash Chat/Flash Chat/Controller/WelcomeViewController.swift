//
//  ViewController.swift
//  Flash Chat
//
//  Created by Александр on 25.02.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Logo animation variant without CLTypingLabel pod
         
        titleLabel.text = ""
        var charIndex = 0.0 // Animation delay depending on char index
        let titleText = K.appName
        
        for letter in titleText {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            
            charIndex += 1
        }
    }

}

