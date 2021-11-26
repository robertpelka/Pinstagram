//
//  CommentsView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 25/11/2021.
//

import SwiftUI

struct CommentsView: View {
    @State var commentText: String = ""
    @ObservedObject var viewModel: CommentsViewModel
    
    @State private var shouldShowAlert = false
    @State var errorMessage: String?
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 22) {
                    if viewModel.comments.isEmpty {
                        Text("No comments yet. Be the first!")
                            .padding(.top, 25)
                    }
                    else {
                        ForEach(viewModel.comments) { comment in
                            CommentCell(viewModel: CommentCellViewModel(comment: comment))
                        }
                    }
                }
                .padding(.top)
            }
            
            Spacer()
            
            Divider()
            HStack(spacing: 12) {
                WebImage(url: URL(string: AuthViewModel.shared.currentUser?.profileImage ?? ""))
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 36, height: 36)
                
                CommentTextField(commentText: $commentText)
                
                Spacer()
                
                Button {
                    if commentText == "" {
                        shouldShowAlert = true
                        errorMessage = "Comment cannot be empty."
                    }
                    else {
                        viewModel.postComment(withText: commentText) {
                            self.hideKeyboard()
                            commentText = ""
                        }
                    }
                } label: {
                    Text("Post")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 2)
            Divider()
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            self.hideKeyboard()
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(errorMessage ?? "Error"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(viewModel: CommentsViewModel.init(postID: ""))
    }
}

struct CommentTextField: View {
    @Binding var commentText: String
    
    var body: some View {
        TextField("Add a comment...", text: $commentText)
    }
}
