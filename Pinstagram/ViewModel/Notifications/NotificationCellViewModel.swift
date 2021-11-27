//
//  NotificationCellView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 27/11/2021.
//

import Foundation

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? "some time"
    }
    
    var notificationText: String {
        switch notification.type {
        case .like:
            return " liked one of your posts. "
        case .comment:
            return " commented on one of your posts. "
        case .follow:
            return " started following you. "
        }
    }
    
    init(notification: Notification) {
        self.notification = notification
        fetchUser()
        fetchPost()
    }
    
    func fetchUser() {
        K.Collections.users.document(notification.userID).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting user snapshot: \(error.localizedDescription)")
                return
            }
            if let document = document {
                do {
                    self.notification.user = try document.data(as: User.self)
                }
                catch let error {
                    print("DEBUG: Error fetching user: \(error.localizedDescription)")
                    return
                }
                self.checkIfUserIsFollowed()
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.following.document(currentUserID).collection("followedUsers").document(notification.userID).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching followed users: \(error.localizedDescription)")
            }
            if snapshot?.exists == true {
                self.notification.user?.isFollowed = true
            }
        }
    }
    
    func fetchPost() {
        guard let postID = notification.postID else { return }
        
        K.Collections.posts.document(postID).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting post snapshot: \(error.localizedDescription)")
                return
            }
            if let document = document {
                do {
                    self.notification.post = try document.data(as: Post.self)
                }
                catch let error {
                    print("DEBUG: Error fetching post: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
}
