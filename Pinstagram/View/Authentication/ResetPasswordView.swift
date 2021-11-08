//
//  ResetPasswordView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 07/10/2021.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shouldShowAlert = false
    @State var errorMessage: String?
    
    @State var isLoading = false
    @State var isButtonDisabled = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [K.Colors.primary, Color(red: 158/255, green: 154/255, blue: 43/255), Color(red: 185/255, green: 77/255, blue: 16/255)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image("logo")
                    .padding()
                
                CustomTextField(text: $email, placeholder: "Email", imageName: "envelope.fill", isSecure: false)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                Button(action: {
                    isLoading = true
                    isButtonDisabled = true
                    viewModel.sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            shouldShowAlert = true
                            errorMessage = error.localizedDescription
                            isLoading = false
                            isButtonDisabled = false
                        }
                        else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }, label: {
                    PrimaryButton(text: "Reset Password", isLoading: $isLoading)
                        .padding(.top, 15)
                })
                    .disabled(isButtonDisabled)
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Go back to")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .light))
                    +
                    Text(" Login Screen.")
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

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
