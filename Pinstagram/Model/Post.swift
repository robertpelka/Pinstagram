//
//  Post.swift
//  Pinstagram
//
//  Created by Robert Pelka on 08/11/2021.
//

import Foundation
import Firebase
import MapKit

struct Post: Codable, Identifiable {
    let id: String
    let image: String
    let description: String
    let ownerID: String
    var numberOfLikes = 0
    let timestamp: Timestamp
    let longitude: Double
    let latitude: Double
    let city: String
    let country: String
    let flag: String
    
    var owner: User?
    var timestampString: String?
    var coordinate: CLLocationCoordinate2D? {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
