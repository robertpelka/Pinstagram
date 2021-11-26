//
//  CommentCellViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 26/11/2021.
//

import Foundation

class CommentCellViewModel: ObservableObject {
    @Published var comment: Comment
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: comment.timestamp.dateValue(), to: Date()) ?? "some time"
    }
    
    init(comment: Comment) {
        self.comment = comment
        self.fetchCommentAuthor()
    }
    
    func fetchCommentAuthor() {
        K.Collections.users.document(comment.authorID).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error getting comment owner snapshot: \(error.localizedDescription)")
                return
            }
            
            do {
                if let commentAuthor = try snapshot?.data(as: User.self) {
                    self.comment.author = commentAuthor
                }
            }
            catch let error {
                print("DEBUG: Error fetching comment author: \(error.localizedDescription)")
            }
        }
    }
}
