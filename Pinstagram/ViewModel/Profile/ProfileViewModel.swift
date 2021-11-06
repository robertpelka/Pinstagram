//
//  ProfileViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 06/11/2021.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    /*@Published*/ var user: User
    
    init(user: User) {
        self.user = user
    }
}
