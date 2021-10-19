//
//  ProfileView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    @State var isCurrentUser: Bool
    @State var bio = "I love traveling, wine and making new friends. Watching netflix is my passion 🤪"
    
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
                    Image("profileImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Andrew")
                            .font(.system(size: 18, weight: .semibold))
                        Text(bio)
                            .font(.system(size: 16, weight: .regular))
                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack {
                        Text("Countries")
                            .font(.system(size: 18, weight: .semibold))
                        Text("7")
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Followers")
                            .font(.system(size: 18, weight: .semibold))
                        Text("124")
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Following")
                            .font(.system(size: 18, weight: .semibold))
                        Text("92")
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 2)
                
                if isCurrentUser {
                    NavigationLink {
                        EditProfileView(bio: $bio)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Edit Profile")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, minHeight: 38)
                            .border(K.Colors.primary, width: 2)
                            .cornerRadius(5)
                            .padding()
                    }
                }
                else {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Follow")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 38)
                            .background(K.Colors.primary)
                            .cornerRadius(5)
                            .padding()
                    })
                }
                
                Map(coordinateRegion: $coordinateRegion,
                    annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        NavigationLink(
                            destination: FeedCell(),
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
                if isCurrentUser {
                    Button("Logout") {
                        print("Logout tapped!")
                    }
                }
            }
        }
        .accentColor(.primary)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isCurrentUser: true)
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
