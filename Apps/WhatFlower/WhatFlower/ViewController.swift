//
//  ViewController.swift
//  WhatFlower
//
//  Created by Александр on 25.03.2021.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var chosenImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    // Lile cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
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
                self.navigationItem.title = firstResult.identifier.capitalized
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
}

