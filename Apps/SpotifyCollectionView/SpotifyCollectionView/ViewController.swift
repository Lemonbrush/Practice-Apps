//
//  ViewController.swift
//  SpotifyCollectionView
//
//  Created by Alexander Rubtsov on 25.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var toolBar: ToolBarCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toolBar = ToolBarCollectionView(frame: self.view.frame, collectionViewLayout: ZoomAndSnapFlowLayout())
        
        view.addSubview(toolBar)
    }

}



