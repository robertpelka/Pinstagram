//
//  UserService.swift
//  Pinstagram
//
//  Created by Robert Pelka on 14/11/2021.
//

import Foundation

struct UserService {
    static func followUser(withID followedUserID: String, completion: ((Error?) -> Void)?) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        K.Collections.followers.document(followedUserID).collection("userFollowers").document(currentUserID).setData([:]) { error in
            if let error = error {
                print("DEBUG: Error following user: \(error.localizedDescription)")
            }
            K.Collections.following.document(currentUserID).collection("followedUsers").document(followedUserID).setData([:], completion: completion)
        }
    }
    
    static func unfollowUser(withID unfollowedUserID: String, completion: ((Error?) -> Void)?) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        K.Collections.followers.document(unfollowedUserID).collection("userFollowers").document(currentUserID).delete { error in
            if let error = error {
                print("DEBUG: Error unfollowing user: \(error.localizedDescription)")
            }
            K.Collections.following.document(currentUserID).collection("followedUsers").document(unfollowedUserID).delete(completion: completion)
        }
    }
}
