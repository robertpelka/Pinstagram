//
//  Icon.swift
//  Pinstagram
//
//  Created by Robert Pelka on 20/10/2021.
//

import SwiftUI

struct Icon: View {
    var imageName: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Image(systemName: imageName)
                .environment(\.symbolVariants, .none)
        }
        else {
            Image(systemName: imageName)
        }
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon(imageName: "house")
    }
}
