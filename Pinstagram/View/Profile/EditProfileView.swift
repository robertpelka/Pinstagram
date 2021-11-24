//
//  EditProfileView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 19/10/2021.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var bio: String
    @Binding var profileImageURL: String
    @State private var selectedImage: UIImage?
    @State private var isBioChanged = false
    
    @ObservedObject var viewModel = EditProfileViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPickerPresented = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Profile photo")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 16)
                
                Button(action: {
                    isPickerPresented = true
                }, label: {
                    VStack {
                        if let profileImage = selectedImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                        }
                        else {
                            WebImage(url: URL(string: profileImageURL))
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                        }
                        Text("Change profile picture")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .regular))
                    }
                })
                .sheet(isPresented: $isPickerPresented) {
                    PhotoPicker(image: $selectedImage, coordinate: .constant(nil))
                }
            }
            .padding()
            .padding(.top, 5)
            
            VStack {
                Text("Your bio")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 16)
                TextEditor(text: $bio)
                    .font(.system(size: 16))
                    .frame(height: 85)
                    .onChange(of: bio) { _ in
                        isBioChanged = true
                    }
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: -15) {
                Button(action: {
                    if let profileImage = selectedImage {
                        viewModel.updateProfilePicture(image: profileImage) { imageURL in
                            self.profileImageURL = imageURL
                        }
                    }
                    if isBioChanged {
                        viewModel.updateBio(bio: bio)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    PrimaryButton(text: "Save Changes", isLoading: .constant(false))
                })
            
                Button {
                    AuthViewModel.shared.fetchCurrentUser()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    SecondaryButton(text: "Cancel")
                }
                .padding(.bottom)

            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(bio: .constant("I love traveling, wine and making new friends. Watching netflix is my passion 🤪"), profileImageURL: .constant(""))
    }
}
