//
//  RegisterView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 07/10/2021.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [K.Colors.primary, Color(red: 158/255, green: 154/255, blue: 43/255), Color(red: 185/255, green: 77/255, blue: 16/255)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image("logo")
                    .padding()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    VStack {
                        Image("addPictureCircle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                        Text("Add profile picture")
                            .foregroundColor(.white)
                    }
                })
                .padding(.bottom)
                
                CustomTextField(text: $email, placeholder: "Email", imageName: "envelope.fill", isSecure: false)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                CustomTextField(text: $password, placeholder: "Password", imageName: "key.fill", isSecure: true)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                CustomTextField(text: $username, placeholder: "Username", imageName: "person.fill", isSecure: false)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                Button(action: {
                    viewModel.register(withEmail: email, password: password, username: username)
                }, label: {
                    PrimaryButton(text: "Sign Up")
                        .padding(.top, 15)
                })
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Already have an account?")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .light))
                        +
                        Text(" Log in.")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
        }
        .navigationBarHidden(true)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()    
    }
}
