//
//  ViewController.swift
//  Poke3D
//
//  Created by Александр on 02.04.2021.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true //Add light to the 3D models
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Image configuration for the future recognition
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Car Cards", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2 //Rotate by 90 degrees
            
            node.addChildNode(planeNode)
            
            // Adding the 3D model on the plane
            if imageAnchor.referenceImage.name == "RRover" {
            
                if  let pokeScene = SCNScene(named: "art.scnassets/RCar.usdz") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        // I made rotate configuration in the scn file
                        //pokeNode.eulerAngles.x += Float.pi/2
                        //pokeNode.eulerAngles.z += Float.pi/2
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "YCar" {
                
                if  let pokeScene = SCNScene(named: "art.scnassets/YCar.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        print("everything should be ok")
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
        }
        
        
        return node
    }
}
