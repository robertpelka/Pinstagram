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
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        K.Collections.posts.getDocuments { snapshot, error in
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
