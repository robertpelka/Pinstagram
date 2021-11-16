//
//  ProfileView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI
import MapKit
import Firebase

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State var bio: String = ""
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    let places = [
        Place(latitude: 30.033333, longitude: 31.233334, image: "postImage"),
        Place(latitude:  52.237049, longitude: 21.017532, image: "profileImage"),
        Place(latitude: 48.864716, longitude: 2.349014, image: "postImage")
    ]
    
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 25),
        span: MKCoordinateSpan(latitudeDelta: 80.0, longitudeDelta: 80.0))
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    WebImage(url: URL(string: viewModel.user.profileImage))
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(viewModel.user.username)
                            .font(.system(size: 18, weight: .semibold))
                        Text(viewModel.user.bio)
                            .font(.system(size: 16, weight: .regular))
                    }
                    
                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack {
                        Text("Countries")
                            .font(.system(size: 18, weight: .semibold))
                        Text(String(viewModel.user.visitedCountries))
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Followers")
                            .font(.system(size: 18, weight: .semibold))
                        Text(String(viewModel.user.followers))
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Following")
                            .font(.system(size: 18, weight: .semibold))
                        Text(String(viewModel.user.following))
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 2)
                
                if viewModel.user.isCurrentUser {
                    NavigationLink {
                        EditProfileView(bio: $bio)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        SecondaryButton(text: "Edit Profile")
                    }
                }
                else if viewModel.user.isFollowed == true {
                    Button(action: {
                        UserService.unfollowUser(withID: viewModel.user.id) { error in
                            if let error = error {
                                print("DEBUG: Error unfollowing user: \(error.localizedDescription)")
                            }
                            viewModel.user.isFollowed = false
                        }
                    }, label: {
                        SecondaryButton(text: "Unfollow")
                    })
                }
                else {
                    Button(action: {
                        UserService.followUser(withID: viewModel.user.id) { error in
                            if let error = error {
                                print("DEBUG: Error following user: \(error.localizedDescription)")
                            }
                            viewModel.user.isFollowed = true
                        }
                    }, label: {
                        PrimaryButton(text: "Follow", isLoading: .constant(false))
                    })
                }
                
                Map(coordinateRegion: $coordinateRegion,
                    annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        NavigationLink(
                            destination: Text("FeedCell"),
                            label: {
                                ZStack {
                                    Image("pin")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 60)
                                    Image(place.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                        .padding(.bottom, 20)
                                }
                                .padding(.bottom, 60)
                            })
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.user.isCurrentUser {
                    Button("Logout") {
                        AuthViewModel.shared.logOut()
                    }
                }
            }
        }
        .accentColor(.primary)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(user: User(id: "", username: "Username", profileImage: "")))
    }
}

struct Place: Identifiable {
    var id = UUID()
    let latitude: Double
    let longitude: Double
    let image: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
