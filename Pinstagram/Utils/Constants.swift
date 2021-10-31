//
//  Constants.swift
//  Pinstagram
//
//  Created by Robert Pelka on 17/10/2021.
//

import Foundation
import SwiftUI
import Firebase

struct K {
    struct Colors {
        static let primary = Color(red: 43/255, green: 158/255, blue: 110/255)
    }
    
    struct Collections {
        static let users = Firestore.firestore().collection("users")
    }
}