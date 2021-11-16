//
//  FeedCellViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 16/11/2021.
//

import Foundation

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        fetchPostOwner()
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
}
