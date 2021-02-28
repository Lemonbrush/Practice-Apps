//
//  Constants.swift
//  Flash Chat
//
//  Created by Александр on 28.02.2021.
//

import Foundation

// This file contains all the necessary constants
struct K {
    
    static let appName = "⚡️FlashChat"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "message"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}
