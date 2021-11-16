//
//  FeedViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 16/11/2021.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        fetchFollowedUsersPosts()
    }
    
    func fetchFollowedUsersPosts() {
        fetchFollowedUsersIDS { followedUsersIDS in
            K.Collections.posts.whereField("ownerID", in: followedUsersIDS).order(by: "timestamp", descending: true).getDocuments { snapshot, error in
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
    
    func fetchFollowedUsersIDS(completion: @escaping ([String]) -> ()) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        K.Collections.following.document(currentUserID).collection("followedUsers").getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching followed users: \(error.localizedDescription)")
            }
            if let documents = snapshot?.documents {
                var followedUsersIDS = [String]()
                for document in documents {
                    followedUsersIDS.append(document.documentID)
                }
                completion(followedUsersIDS)
            }
        }
    }
    
}
