//
//  ProfileViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 06/11/2021.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    
    init(userID: String) {
        fetchUser(withID: userID)
    }
    
    func fetchUser(withID userID: String) {
        K.Collections.users.document(userID).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting user snapshot: \(error.localizedDescription)")
                return
            }
            if let document = document {
                do {
                    self.user = try document.data(as: User.self)
                }
                catch let error {
                    print("DEBUG: Error fetching user: \(error.localizedDescription)")
                    return
                }
                self.checkIfUserIsFollowed()
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let userID = user?.id else { return }
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        K.Collections.following.document(currentUserID).collection("followedUsers").document(userID).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching followed users: \(error.localizedDescription)")
            }
            if snapshot?.exists == true {
                self.user?.isFollowed = true
            }
        }
    }
    
}
