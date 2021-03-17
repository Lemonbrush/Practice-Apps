//
//  Item.swift
//  Todoey_Realm
//
//  Created by Александр on 15.03.2021.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // Inverse relationship
    // Each Item comes from Category property List named "items"
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") // Inverse relationship
}
