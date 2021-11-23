//
//  FeedCell.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI
import Firebase

struct FeedCell: View {
    @ObservedObject var viewModel: FeedCellViewModel
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                if let postOwner = viewModel.post.owner {
                    NavigationLink {
                        ProfileView(viewModel: ProfileViewModel(user: postOwner))
                    } label: {
                        WebImage(url: URL(string: viewModel.post.owner?.profileImage ?? ""))
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.leading, 10)
                            .padding(.trailing, 0)
                        
                        Text(viewModel.post.owner?.username ?? "")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                else {
                    WebImage(url: URL(string: viewModel.post.owner?.profileImage ?? ""))
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                        .padding(.trailing, 0)
                    
                    Text(viewModel.post.owner?.username ?? "")
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Text(" was in ")
                    .font(.system(size: 16, weight: .regular))
                +
                Text(viewModel.post.country + viewModel.post.flag)
                    .font(.system(size: 16, weight: .semibold))
            }
            
            WebImage(url: URL(string: viewModel.post.image))
                .scaledToFill()
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.width, maxHeight: 500)
                .fixedSize(horizontal: false, vertical: true)
                .clipped()
            
            HStack {
                Button {
                    if viewModel.post.isLiked == true {
                        viewModel.unlikePost()
                    }
                    else {
                        viewModel.likePost()
                    }
                } label: {
                    if viewModel.post.isLiked == true {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                            .font(.system(size: 26, weight: .light))
                    }
                    else {
                        Image(systemName: "heart")
                            .font(.system(size: 26, weight: .light))
                    }
                }
                Image(systemName: "bubble.right")
                    .font(.system(size: 26, weight: .light))
                Spacer()
                Image("pin")
                Text(viewModel.post.city + ", " + viewModel.post.country)
                    .font(.system(size: 16, weight: .regular))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            Text(String(viewModel.post.numberOfLikes) + ((viewModel.post.numberOfLikes == 1) ? " like" : " likes"))
                .font(.system(size: 16, weight: .semibold))
                .padding(.leading, 10)
            
            Group {
                Text(viewModel.post.owner?.username ?? "")
                    .font(.system(size: 16, weight: .semibold))
                +
                Text(" " + viewModel.post.description)
                    .font(.system(size: 16, weight: .regular))
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
            
            Text(viewModel.timestampString + " ago")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.secondary)
                .padding(.leading, 10)
                .padding(.top, 2)
        }
        .padding(.vertical, 14)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(viewModel: FeedCellViewModel(post: Post(id: "", image: "", description: "", ownerID: "", timestamp: Timestamp(), longitude: 0, latitude: 0, city: "", country: "", flag: "")))
    }
}
