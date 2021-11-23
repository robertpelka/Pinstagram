//
//  MainTabViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 23/11/2021.
//

import Foundation

class MainTabViewModel: ObservableObject {
    @Published var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
}
