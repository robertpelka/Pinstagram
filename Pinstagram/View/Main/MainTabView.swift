//
//  MainTabView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct MainTabView: View {
    @State var selection = 0
    @ObservedObject var viewModel: MainTabViewModel
    
    var body: some View {
        TabView(selection: $selection) {
            FeedView()
                .tabItem {
                    let imageName = (selection == 0) ? "house.fill" : "house"
                    Icon(imageName: imageName)
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    let imageName = (selection == 1) ? "text.magnifyingglass" : "magnifyingglass"
                    Icon(imageName: imageName)
                }
                .tag(1)
            
            NewPostView(tabSelection: $selection)
                .tabItem {
                    let imageName = (selection == 2) ? "plus.square.fill" : "plus.square"
                    Icon(imageName: imageName)
                }
                .tag(2)
            
            NotificationsView()
                .tabItem {
                    let imageName = (selection == 3) ? "heart.fill" : "heart"
                    Icon(imageName: imageName)
                }
                .tag(3)
            
            NavigationView {
                ProfileView(viewModel: ProfileViewModel(user: viewModel.currentUser))
            }
            .tabItem {
                let imageName = (selection == 4) ? "person.fill" : "person"
                Icon(imageName: imageName)
            }
            .tag(4)
        }
        .accentColor(.primary)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(viewModel: MainTabViewModel(currentUser: User(id: "", username: "Andrew", profileImage: "")))
    }
}
