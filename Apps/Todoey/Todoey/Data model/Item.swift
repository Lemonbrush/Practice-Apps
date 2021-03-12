//
//  Item.swift
//  Todoey
//
//  Created by Александр on 12.03.2021.
//

import Foundation

class Item {
    var title: String = ""
    var isDone: Bool = false
    
    init(_ title: String = "???", isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}
