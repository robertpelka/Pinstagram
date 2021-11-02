//
//  LoginView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 05/10/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var shouldShowAlert = false
    @State var errorMessage: String?
    @State var isLoading = false
    @State var isButtonDisabled = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [K.Colors.primary, Color(red: 158/255, green: 154/255, blue: 43/255), Color(red: 185/255, green: 77/255, blue: 16/255)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                        .padding()
                    
                    CustomTextField(text: $email, placeholder: "Email", imageName: "envelope.fill", isSecure: false)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomTextField(text: $password, placeholder: "Password", imageName: "key.fill", isSecure: true)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            ResetPasswordView()
                        } label: {
                            Text("Forgot password?")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                                .padding(.trailing)
                        }
                    }
                    
                    Button(action: {
                        isLoading = true
                        isButtonDisabled = true
                        viewModel.logIn(withEmail: email, password: password) { _, error in
                            if let error = error {
                                shouldShowAlert = true
                                errorMessage = error.localizedDescription
                                isLoading = false
                                isButtonDisabled = false
                            }
                            else {
                                viewModel.fetchCurrentUser()
                            }
                        }
                    }, label: {
                        PrimaryButton(text: "Log In", isLoading: $isLoading)
                            .padding(.top, 15)
                    })
                        .disabled(isButtonDisabled)
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .light))
                        +
                        Text(" Join us.")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
            .navigationBarHidden(true)
            .onTapGesture {
                self.hideKeyboard()
            }
            .alert(isPresented: $shouldShowAlert) {
                Alert(title: Text(errorMessage ?? "Error"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
