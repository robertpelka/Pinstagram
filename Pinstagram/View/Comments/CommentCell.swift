//
//  CommentCell.swift
//  Pinstagram
//
//  Created by Robert Pelka on 25/11/2021.
//

import SwiftUI
import Firebase

struct CommentCell: View {
    @ObservedObject var viewModel: CommentCellViewModel
    
    init(viewModel: CommentCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if let commentAuthor = viewModel.comment.author {
                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(user: commentAuthor))
                } label: {
                    WebImage(url: URL(string: viewModel.comment.author?.profileImage ?? ""))
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                }
            }
            else {
                WebImage(url: URL(string: viewModel.comment.author?.profileImage ?? ""))
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 36, height: 36)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.comment.author?.username ?? "Robert") ")
                    .font(.system(size: 16, weight: .semibold))
                +
                Text(viewModel.comment.text)
                    .font(.system(size: 16, weight: .regular))
                
                Text(viewModel.timestampString + " ago")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(viewModel: CommentCellViewModel(comment: Comment(id: "", text: "", authorID: "", timestamp: Timestamp(date: Date()))))
    }
}
