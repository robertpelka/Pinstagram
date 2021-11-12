//
//  User.swift
//  Pinstagram
//
//  Created by Robert Pelka on 23/10/2021.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let username: String
    var profileImage: String
    var bio: String = "Hello, I'm new here 😊"
    var visitedCountries: Int = 0
    var followers: Int = 0
    var following: Int = 0
    
    var isCurrentUser: Bool {
        return AuthViewModel.shared.currentUser?.id == self.id
    }
}
