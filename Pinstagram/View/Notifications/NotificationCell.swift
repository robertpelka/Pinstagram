//
//  NotificationCell.swift
//  Pinstagram
//
//  Created by Robert Pelka on 15/10/2021.
//

import SwiftUI
import Firebase

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel
    
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(user: user))
                } label: {
                    WebImage(url: URL(string: viewModel.notification.user?.profileImage ?? ""))
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 52, height: 52)
                }
            }
            
            Group {
                Text(viewModel.notification.user?.username ?? "")
                    .font(.system(size: 16, weight: .semibold))
                    +
                Text(viewModel.notificationText)
                    .font(.system(size: 16, weight: .regular))
                    +
                Text("\(viewModel.timestampString) ago")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 2)
            
            Spacer()
            
            if viewModel.notification.type == .follow, let user = viewModel.notification.user {
                if user.isFollowed == true {
                    Button(action: {
                        UserService.unfollowUser(withID: user.id) {
                            viewModel.notification.user?.isFollowed = false
                        }
                    }, label: {
                        Text("Unfollow")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                            .frame(width: 99, height: 38)
                            .border(K.Colors.primary, width: 2)
                            .cornerRadius(5)
                    })
                }
                else {
                    Button(action: {
                        UserService.followUser(withID: user.id) {
                            viewModel.notification.user?.isFollowed = true
                        }
                    }, label: {
                        Text("Follow")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 99, height: 38)
                            .background(K.Colors.primary)
                            .cornerRadius(5)
                    })
                }
            }
            else {
                if let post = viewModel.notification.post {
                    NavigationLink {
                        ScrollView {
                            FeedCell(viewModel: FeedCellViewModel(post: post))
                        }
                    } label: {
                        WebImage(url: URL(string: post.image))
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .clipped()
                    }
                }
            }
        }
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(viewModel: NotificationCellViewModel(notification: Notification(id: "", type: .like, userID: "", postID: "", timestamp: Timestamp())))
    }
}

