//
//  NotificationsViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 27/11/2021.
//

import Foundation
import Firebase

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications() {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.users.document(currentUserID).collection("notifications").order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Error getting notifications snapshot: \(error.localizedDescription)")
                return
            }
            if let documents = snapshot?.documents {
                self.notifications = [Notification]()
                for document in documents {
                    do {
                        if let notification = try document.data(as: Notification.self) {
                            self.notifications.append(notification)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error fetching notification: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    static func uploadNotification(forUserID userID: String, type: NotificationType, postID: String?) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        let notificationID = UUID().uuidString
        let notification = Notification(id: notificationID, type: type, userID: currentUserID, postID: postID, timestamp: Timestamp(date: Date()))
        
        do {
            try K.Collections.users.document(userID).collection("notifications").document(notificationID).setData(from: notification)
        }
        catch let error {
            print("DEBUG: Error uploading notification: \(error.localizedDescription)")
            return
        }
    }
    
}
