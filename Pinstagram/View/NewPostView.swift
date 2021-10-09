//
//  NewPostView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct NewPostView: View {
    var body: some View {
        NavigationView {
            Text("New Post")
                .navigationTitle("New Post")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
