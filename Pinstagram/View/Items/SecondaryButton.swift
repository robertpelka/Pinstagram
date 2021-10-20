//
//  SecondaryButton.swift
//  Pinstagram
//
//  Created by Robert Pelka on 20/10/2021.
//

import SwiftUI

struct SecondaryButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, minHeight: 38)
            .border(K.Colors.primary, width: 2)
            .cornerRadius(5)
            .padding()
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(text: "Edit Profile")
    }
}
