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
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserPosts()
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
    
    func fetchUserPosts() {
        K.Collections.posts.whereField("ownerID", isEqualTo: user.id).getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error getting posts snapshot: \(error.localizedDescription)")
                return
            }
            if let documents = snapshot?.documents {
                for document in documents {
                    do {
                        let post = try document.data(as: Post.self)
                        if let post = post {
                            self.posts.append(post)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error fetching posts: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
    
}
