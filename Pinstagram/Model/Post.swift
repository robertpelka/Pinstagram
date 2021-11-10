//
//  Post.swift
//  Pinstagram
//
//  Created by Robert Pelka on 08/11/2021.
//

import Foundation
import Firebase

struct Post: Codable {
    let id: String
    let image: String
    let ownerID: String
    var numberOfLikes = 0
    let timestamp: Timestamp
    let longitude: Double
    let latitude: Double
    let city: String
    let country: String
    let flag: String
}
