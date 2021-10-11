//
//  PostGrid.swift
//  Pinstagram
//
//  Created by Robert Pelka on 11/10/2021.
//

import SwiftUI

struct PostGrid: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(spacing: 2), GridItem(spacing: 2), GridItem(spacing: 2)], alignment: .center, spacing: 2, content: {
            ForEach(1..<12) { _ in
                Color.clear
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        Image("postImage")
                            .resizable()
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
