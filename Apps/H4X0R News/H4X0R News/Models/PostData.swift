//
//  PostData.swift
//  H4X0R News
//
//  Created by Александр on 07.03.2021.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

// Identifiable allows to identify order of that post by ID
struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let points: Int
    let url: String?
}
