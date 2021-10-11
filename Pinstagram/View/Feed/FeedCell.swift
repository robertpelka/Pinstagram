//
//  FeedCell.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.leading, 10)
                    .padding(.trailing, 5)
                
                Text("Andrew")
                    .font(.system(size: 16, weight: .semibold))
                    +
                    Text(" was in ")
                    .font(.system(size: 16, weight: .regular))
                    +
                    Text("France 🇫🇷")
                    .font(.system(size: 16, weight: .semibold))
            }
            
            Image("postImage")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 500)
                .fixedSize(horizontal: false, vertical: true)
                .clipped()
            
            HStack {
                Image(systemName: "heart")
                    .font(.system(size: 26, weight: .light))
                Image(systemName: "bubble.right")
                    .font(.system(size: 26, weight: .light))
                Spacer()
                Image("pin")
                Text("Paris, France")
                    .font(.system(size: 16, weight: .regular))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            Text("128 likes")
                .font(.system(size: 16, weight: .semibold))
                .padding(.leading, 10)
            
            Group {
                Text("Andrew")
                    .font(.system(size: 16, weight: .semibold))
                    +
                    Text(" This place was Amazing. Once you reach the place you will get astonished by the beauty of everything.")
                    .font(.system(size: 16, weight: .regular))
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
            
            Text("2d ago")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.secondary)
                .padding(.leading, 10)
                .padding(.top, 2)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
