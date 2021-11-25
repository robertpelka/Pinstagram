//
//  CommentsView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 25/11/2021.
//

import SwiftUI

struct CommentsView: View {
    @Binding var commentText: String
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 22) {
                        ForEach(1..<5) { _ in
                            CommentCell()
                        }
                    }
                    .padding(.top)
                }
                
                Spacer()
                
                Divider()
                HStack(spacing: 12) {
                    Image("profileImage")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                    
                    TextField("Add a comment...", text: $commentText)
                    
                    Spacer()
                    
                    Text("Post")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color.blue)
                }
                .padding(.horizontal)
                .padding(.vertical, 2)
                Divider()
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.primary)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(commentText: .constant(""))
    }
}
