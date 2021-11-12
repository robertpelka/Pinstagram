//
//  PostGrid.swift
//  Pinstagram
//
//  Created by Robert Pelka on 11/10/2021.
//

import SwiftUI

struct PostGrid: View {
    var posts = [Post]()
    
    var body: some View {
        LazyVGrid(columns: [GridItem(spacing: 2), GridItem(spacing: 2), GridItem(spacing: 2)], alignment: .center, spacing: 2, content: {
            ForEach(posts) { post in
                Color.clear
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        WebImage(url: URL(string: post.image))
                            .scaledToFill()
                    )
                    .clipped()
            }
        })
    }
}

struct PostGrid_Previews: PreviewProvider {
    static var previews: some View {
        PostGrid()
    }
}
