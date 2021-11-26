//
//  Comment.swift
//  Pinstagram
//
//  Created by Robert Pelka on 26/11/2021.
//

import Foundation
import Firebase

struct Comment: Codable, Identifiable {
    let id: String
    let text: String
    let authorID: String
    let timestamp: Timestamp
    
    var author: User?
}
