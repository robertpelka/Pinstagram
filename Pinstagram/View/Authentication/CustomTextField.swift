//
//  CustomTextField.swift
//  Pinstagram
//
//  Created by Robert Pelka on 05/10/2021.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var imageName: String
    var isSecure: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(.displayP3, red: 0, green: 0, blue: 0, opacity: 0.08)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white)
                    .padding(.leading, 50)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18, alignment: .center)
                    .padding(.leading, 20)
                    .foregroundColor(.white)
                if isSecure {
                    SecureField("", text: $text)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                }
                else {
                    TextField("", text: $text)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                }
            }
        }
        .frame(height: 54)
        .cornerRadius(5)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: "Email", imageName: "key.fill", isSecure: false)
    }
}
