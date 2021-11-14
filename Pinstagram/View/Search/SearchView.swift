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
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBar(searchText: $searchText, isEditing: $isEditing)
                    .padding(.vertical, 15)
                    .onChange(of: searchText) { _ in
                        viewModel.fetchUsers(withName: searchText)
                    }
                
                ScrollView {
                    if isEditing {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.users) { user in
                                NavigationLink {
                                    ProfileView(viewModel: ProfileViewModel(userID: user.id))
                                } label: {
                                    HStack {
                                        WebImage(url: URL(string: user.profileImage))
                                            .scaledToFill()
                                            .frame(width: 48, height: 48)
                                            .clipShape(Circle())
                                            .padding(.leading, 10)
                                            .padding(.trailing, 2)
                                        
                                        Text(user.username)
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(.vertical, 18)
                                        
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    else {
                        PostGrid(posts: viewModel.posts)
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
