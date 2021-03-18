//
//  Category.swift
//  Todoey_Realm
//
//  Created by Александр on 15.03.2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colorHex: String = "#FFFFFF"
    
    // Define relationships
    let items = List<Item>()
}
