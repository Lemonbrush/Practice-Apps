//
//  ViewController.swift
//  KVOTest
//
//  Created by Alexander Rubtsov on 07.01.2022.
//

import UIKit

class Person: NSObject {
    @objc dynamic var name = "Tailor Swift"
}

class ViewController: UIViewController {
    
    @objc let somePerson = Person()
    
    var nameObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameObservation = observe(\.somePerson.name, options: [.new, .old]) { (vc, change) in
            print(change.oldValue, " renamed to ", change.newValue)
        }
        
        somePerson.name = "Justin Bieber"
    }
}

