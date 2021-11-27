//
//  UserService.swift
//  Pinstagram
//
//  Created by Robert Pelka on 14/11/2021.
//

import Foundation
import Firebase

struct UserService {
    static func followUser(withID followedUserID: String, completion: @escaping () -> Void) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.followers.document(followedUserID).collection("userFollowers").document(currentUserID).setData([:]) { error in
            if let error = error {
                print("DEBUG: Error adding current user to followers list of followed user: \(error.localizedDescription)")
                return
            }
            K.Collections.following.document(currentUserID).collection("followedUsers").document(followedUserID).setData([:]) { error in
                if let error = error {
                    print("DEBUG: Error adding followed user to followed users list of current user: \(error.localizedDescription)")
                    return
                }
                K.Collections.users.document(followedUserID).updateData(["followers" : FieldValue.increment(Int64(1))]) { error in
                    if let error = error {
                        print("DEBUG: Error incrementing followers number of followed user: \(error.localizedDescription)")
                        return
                    }
                    K.Collections.users.document(currentUserID).updateData(["following" : FieldValue.increment(Int64(1))]) { error in
                        if let error = error {
                            print("DEBUG: Error incrementing following number of current user: \(error.localizedDescription)")
                            return
                        }
                        NotificationsViewModel.uploadNotification(forUserID: followedUserID, type: .follow, postID: nil)
                        completion()
                    }
                }
            }
        }
    }
    
    static func unfollowUser(withID unfollowedUserID: String, completion: @escaping () -> Void) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.followers.document(unfollowedUserID).collection("userFollowers").document(currentUserID).delete { error in
            if let error = error {
                print("DEBUG: Error removing current user from followers list of unfollowed user: \(error.localizedDescription)")
                return
            }
            K.Collections.following.document(currentUserID).collection("followedUsers").document(unfollowedUserID).delete { error in
                if let error = error {
                    print("DEBUG: Error removing unfollowed user from followed users list of current user: \(error.localizedDescription)")
                }
                K.Collections.users.document(unfollowedUserID).updateData(["followers" : FieldValue.increment(Int64(-1))]) { error in
                    if let error = error {
                        print("DEBUG: Error decrementing followers number of unfollowed user: \(error.localizedDescription)")
                        return
                    }
                    K.Collections.users.document(currentUserID).updateData(["following" : FieldValue.increment(Int64(-1))]) { error in
                        if let error = error {
                            print("DEBUG: Error decrementing following number of current user: \(error.localizedDescription)")
                            return
                        }
                        completion()
                    }
                }
            }
        }
    }
}
