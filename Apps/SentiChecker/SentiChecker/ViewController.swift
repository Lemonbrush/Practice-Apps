//
//  ViewController.swift
//  TwitterMenti
//
//  Created by Александр on 27.03.2021.
//

import UIKit
import CoreML
import NaturalLanguage

class ViewController: UIViewController, UISearchTextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    var sentimentModel: NLModel? // Model for sentiment predictions
    
    // Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        // Model settings
        guard let model = try? TwitterSentimenter(configuration: MLModelConfiguration()).model else {
            fatalError("Model configuration failed")
        }
        sentimentModel = try! NLModel(mlModel: model)

    }

    // IBActions
    @IBAction func predictPressed(_ sender: UIButton) {
        
        if let searchText = textField.text {
            
            // Show prediction result
            if let prediction = sentimentModel?.predictedLabel(for: searchText) {
                
                if prediction == "Neg" {
                    sentimentLabel.text = "😞"
                } else if prediction == "Pos" {
                    sentimentLabel.text = "😄"
                } else {
                    sentimentLabel.text = "😐"
                }
                
            } else {
                print("Prediction error")
            }
        }
    }
    
}

