//
//  AuthViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 23/10/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isUserLoggedChecked = false
    
    static var shared = AuthViewModel()
    
    init() {
        fetchCurrentUser()
    }
    
    func register(withEmail email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("DEBUG: Error creating new user: \(error.localizedDescription)")
                return
            }
            
            guard let firebaseUser = authResult?.user else { return }
            
            let user = User(id: firebaseUser.uid, username: username, profileImage: "#")
            do {
                try K.Collections.users.document(firebaseUser.uid).setData(from: user)
            }
            catch let error {
                print("DEBUG: Error saving user data to Firestore: \(error.localizedDescription)")
            }
            
            self.fetchCurrentUser()
        }
    }
    
    func fetchCurrentUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            self.isUserLoggedChecked = true
            return
        }
        
        K.Collections.users.document(userID).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting user data: \(error.localizedDescription)")
            }
            do {
                self.currentUser = try document?.data(as: User.self)
                self.isUserLoggedChecked = true
            }
            catch {
                print("DEBUG: Error fetching user: \(error.localizedDescription)")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
        }
        catch {
            print("DEBUG: Error logging out: \(error.localizedDescription)")
        }
    }
    
}
