//
//  ViewController.swift
//  WhatFlower
//
//  Created by Александр on 25.03.2021.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    let imagePicker = UIImagePickerController()
    
    // Lile cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionView.isHidden = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // Image picker methods
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            guard let ciImage = CIImage(image: chosenImage) else {
                fatalError("Error happened while converting image to CIImage")
            }
            
            detect(flowerImage: ciImage)
            
            chosenImageView.image = chosenImage
        }
        
        picker.dismiss(animated: true)
        
    }
    
    // ML methods
    func detect(flowerImage: CIImage) {
        
        // Model decloration
        let config = MLModelConfiguration()
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: config).model) else {
            fatalError("Loading CoreML failed")
        }
        
        // Configurating request for the model
        // The closure triggers when the handler specification finishes
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed getting results from the model")
            }
            
            if let firstResult = results.first {
                
                let flowerName = firstResult.identifier.capitalized
                
                self.navigationItem.title = flowerName
                self.requestInfo(with: flowerName)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    // REST Methods
    func requestInfo(with flowerName: String) {
        
        let parameters : [String:String] = [
            
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
          ]
        
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { response in
            
            print("Wiki says - ",response, " \n\n\n")
            
            let json = JSON(response.value!)
            
            if let pageids = json["query"]["pageids"][0].string {
                
                let flowerDescription = json["query"]["pages"][pageids]["extract"].string
                self.descriptionLabel.text = flowerDescription
                
                let flowerWikiImage = json["query"]["pages"][pageids]["thumbnail"]["source"].string!
                //self.chosenImageView.sd_setImage(with: URL(string: flowerWikiImage))
                
                self.descriptionView.isHidden = false
            }
        }
    }
    
}

