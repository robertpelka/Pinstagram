//
//  ProfileViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 06/11/2021.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        if user.id == currentUserID { return }
        K.Collections.following.document(currentUserID).collection("followedUsers").document(user.id).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching followed users: \(error.localizedDescription)")
            }
            if snapshot?.exists == true {
                self.user.isFollowed = true
            }
        }
    }
    
}
