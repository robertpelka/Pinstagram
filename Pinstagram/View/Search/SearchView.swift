//
//  SearchView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBar(searchText: $searchText, isEditing: $isEditing)
                
                ScrollView {
                    if isEditing {
                        LazyVStack(alignment: .leading) {
                            ForEach(1..<10) { _ in
                                HStack {
                                    Image("profileImage")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .padding(.leading, 10)
                                        .padding(.trailing, 5)
                                    
                                    Text("Andrew")
                                        .font(.system(size: 18, weight: .semibold))
                                        .padding(.vertical, 18)
                                }
                            }
                        }
                        .padding(.top, 15)
                    }
                    else {
                        PostGrid()
                            .padding(.top, 15)
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}