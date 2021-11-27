//
//  FeedCellViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 16/11/2021.
//

import Foundation
import Firebase

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? "some time"
    }
    
    init(post: Post) {
        self.post = post
        fetchPostOwner()
        checkIfPostIsLiked()
    }
    
    func fetchPostOwner() {
        K.Collections.users.document(post.ownerID).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting user snapshot: \(error.localizedDescription)")
                return
            }
            if let document = document {
                do {
                    self.post.owner = try document.data(as: User.self)
                }
                catch let error {
                    print("DEBUG: Error fetching user: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
    
    func likePost() {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.posts.document(post.id).collection("usersThatLiked").document(currentUserID).setData([:]) { error in
            if let error = error {
                print("DEBUG: Error liking post: \(error.localizedDescription)")
                return
            }
            
            self.post.isLiked = true
            
            K.Collections.posts.document(self.post.id).updateData(["numberOfLikes" : FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    print("DEBUG: Error incrementing the number of likes: \(error.localizedDescription)")
                    return
                }
                self.post.numberOfLikes += 1
                NotificationsViewModel.uploadNotification(forUserID: self.post.ownerID, type: .like, postID: self.post.id)
            }
        }
    }
    
    func unlikePost() {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.posts.document(post.id).collection("usersThatLiked").document(currentUserID).delete { error in
            if let error = error {
                print("DEBUG: Error unliking post: \(error.localizedDescription)")
                return
            }
            
            self.post.isLiked = false
            
            K.Collections.posts.document(self.post.id).updateData(["numberOfLikes" : FieldValue.increment(Int64(-1))]) { error in
                if let error = error {
                    print("DEBUG: Error decrementing the number of likes: \(error.localizedDescription)")
                    return
                }
                self.post.numberOfLikes -= 1
            }
        }
    }
    
    func checkIfPostIsLiked() {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.posts.document(post.id).collection("usersThatLiked").document(currentUserID).getDocument { document, error in
            if document?.exists == true {
                self.post.isLiked = true
            }
        }
    }

}
