//
//  Notification.swift
//  Pinstagram
//
//  Created by Robert Pelka on 27/11/2021.
//

import Foundation
import Firebase

struct Notification: Codable, Identifiable {
    let id: String
    let type: NotificationType
    let userID: String
    let postID: String?
    let timestamp: Timestamp
    
    var user: User?
    var post: Post?
}

enum NotificationType: Codable {
    case like
    case comment
    case follow
}
