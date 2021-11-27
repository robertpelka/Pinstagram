//
//  CommentsViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 26/11/2021.
//

import Foundation
import Firebase
    
class CommentsViewModel: ObservableObject {
    var post: Post
    @Published var comments = [Comment]()
    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    func postComment(withText text: String, completion: @escaping () -> ()) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        let commentID = UUID().uuidString
        let comment = Comment(id: commentID, text: text, authorID: currentUserID, timestamp: Timestamp(date: Date()))
        
        do {
            try K.Collections.posts.document(post.id).collection("comments").document(commentID).setData(from: comment)
        }
        catch let error {
            print("DEBUG: Error uploading a comment: \(error.localizedDescription)")
            return
        }
        comments.append(comment)
        NotificationsViewModel.uploadNotification(forUserID: post.ownerID, type: .comment, postID: post.id)
        completion()
    }
    
    func fetchComments() {
        K.Collections.posts.document(post.id).collection("comments").order(by: "timestamp", descending: false).getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error getting comments snapshot: \(error.localizedDescription)")
                return
            }
            
            if let documents = snapshot?.documents {
                self.comments = [Comment]()
                for document in documents {
                    do {
                        if let comment = try document.data(as: Comment.self) {
                            self.comments.append(comment)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error fetching comments: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
