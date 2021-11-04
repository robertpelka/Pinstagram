//
//  AuthViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 23/10/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isUserLoggedChecked = false
    
    static var shared = AuthViewModel()
    
    init() {
        fetchCurrentUser()
    }
    
    func register(withEmail email: String, password: String, username: String, image: UIImage, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let firebaseUser = authResult?.user else { return }
            
            ImageUploader.uploadImage(image: image, fileName: firebaseUser.uid, type: .profileImage) { imageURL in
                let user = User(id: firebaseUser.uid, username: username, profileImage: imageURL)
                do {
                    try K.Collections.users.document(firebaseUser.uid).setData(from: user)
                }
                catch let error {
                    print("DEBUG: Error uploading user data: \(error.localizedDescription)")
                    return
                }
                
                self.fetchCurrentUser()
            }
            
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
    
    func logIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
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
    
    func sendPasswordReset(withEmail email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
}
