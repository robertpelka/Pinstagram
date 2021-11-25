//
//  CommentCell.swift
//  Pinstagram
//
//  Created by Robert Pelka on 25/11/2021.
//

import SwiftUI

struct CommentCell: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("profileImage")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 2) {
                Group {
                    Text("Andrew ")
                        .font(.system(size: 16, weight: .semibold))
                        +
                        Text("Love this photo!")
                        .font(.system(size: 16, weight: .regular))
                }
                .padding(.horizontal, 2)
                
                Text("2d ago")
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
        CommentCell()
    }
}
