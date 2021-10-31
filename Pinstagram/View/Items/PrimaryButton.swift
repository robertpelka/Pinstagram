//
//  PrimaryButton.swift
//  Pinstagram
//
//  Created by Robert Pelka on 20/10/2021.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    @Binding var isLoading: Bool
    
    var body: some View {
        if !isLoading {
            Text(text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 38)
                .background(K.Colors.primary)
                .cornerRadius(5)
                .padding()
        }
        else {
            ProgressView()
                .progressViewStyle(CustomProgressStyle(size: 18))
                .frame(maxWidth: .infinity, minHeight: 38)
                .background(K.Colors.primaryDarker)
                .cornerRadius(5)
                .padding()
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Log In", isLoading: .constant(false))
    }
}
