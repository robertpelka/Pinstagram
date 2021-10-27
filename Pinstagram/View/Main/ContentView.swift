//
//  ContentView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 03/10/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if (viewModel.currentUser != nil) {
            MainTabView()
        }
        else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.preferredColorScheme(.dark)
    }
}
