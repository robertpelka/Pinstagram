//
//  NotificationCell.swift
//  Pinstagram
//
//  Created by Robert Pelka on 15/10/2021.
//

import SwiftUI

struct NotificationCell: View {
    var type: NotificationType
    var notificationText: String {
        switch type {
        case .like:
            return " liked one of your posts. "
        case .comment:
            return " commented on one of your posts. "
        case .follow:
            return " started following you. "
        }
    }
    
    var body: some View {
        HStack {
            Image("profileImage")
                .resizable()
                .clipShape(Circle())
                .frame(width: 52, height: 52)
            
            Group {
                Text("Andrew")
                    .font(.system(size: 16, weight: .semibold))
                    +
                    Text(notificationText)
                    .font(.system(size: 16, weight: .regular))
                    +
                    Text("2d ago")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 2)
            
            Spacer()
            
            if type == .follow {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Follow")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 99, height: 38)
                        .background(Color(red: 43/255, green: 158/255, blue: 110/255))
                        .cornerRadius(5)
                })
            }
            else {
                Image("postImage")
                    .resizable()
                    .frame(width: 52, height: 52)
                    .clipped()
            }
        }
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(type: NotificationType.like)
    }
}

enum NotificationType {
    case like
    case comment
    case follow
}
