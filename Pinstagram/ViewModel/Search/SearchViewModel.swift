//
//  SearchViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 12/11/2021.
//

import Foundation
import Firebase

class SearchViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var users = [User]()
    
    init() {
        fetchPosts()
        fetchUsers(withName: "")
    }
    
    func fetchPosts() {
        K.Collections.posts.getDocuments { snapshot, error in
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
    
    func fetchUsers(withName name: String) {
        K.Collections.users.whereField("username", isGreaterThanOrEqualTo: name).whereField("username", isLessThan: name + "z").getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error getting users snapshot: \(error.localizedDescription)")
                return
            }
            if let documents = snapshot?.documents {
                var matchedUsers = [User]()
                for document in documents {
                    do {
                        let user = try document.data(as: User.self)
                        if let user = user {
                            matchedUsers.append(user)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error fetching users: \(error.localizedDescription)")
                        return
                    }
                }
                self.users = matchedUsers
            }
        }
    }
}
