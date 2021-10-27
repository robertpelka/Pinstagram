//
//  PinstagramApp.swift
//  Pinstagram
//
//  Created by Robert Pelka on 03/10/2021.
//

import SwiftUI
import Firebase

@main
struct PinstagramApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
