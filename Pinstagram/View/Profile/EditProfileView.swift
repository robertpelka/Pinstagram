//
//  EditProfileView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 19/10/2021.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var bio: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            VStack {
                Text("Profile photo")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 16)
                Image("profileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                Text("Change Photo")
                    .foregroundColor(.blue)
                    .font(.system(size: 18, weight: .regular))
            }
            .padding()
            
            VStack {
                Text("Your bio")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 16)
                TextEditor(text: $bio)
                    .font(.system(size: 16))
                    .frame(height: 85)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                PrimaryButton(text: "Save Changes")
                    .padding(.bottom, 25)
            })
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(bio: .constant("I love traveling, wine and making new friends. Watching netflix is my passion 🤪"))
    }
}
