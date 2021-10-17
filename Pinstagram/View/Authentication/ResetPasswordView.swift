//
//  ResetPasswordView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 07/10/2021.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    
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
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Reset Password")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 38)
                        .background(K.Colors.primary)
                        .cornerRadius(5)
                        .padding()
                        .padding(.top, 15)
                })
                
                Text("Go back to")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .light))
                    +
                    Text(" Login Screen.")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .previewDevice("iPhone SE (2nd generation)")
    }
}
