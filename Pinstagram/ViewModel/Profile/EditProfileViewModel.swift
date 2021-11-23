//
//  EditProfileViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 20/11/2021.
//

import Foundation
import UIKit

class EditProfileViewModel: ObservableObject {
    
    func updateProfilePicture(image: UIImage, completion: @escaping (String) -> Void) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        ImageUploader.uploadImage(image: image, fileName: currentUserID, type: .profileImage) { imageURL in
            K.Collections.users.document(currentUserID).updateData(["profileImage" : imageURL]) { error in
                if let error = error {
                    print("DEBUG: Error updating user profile image: \(error.localizedDescription)")
                }
                AuthViewModel.shared.fetchCurrentUser()
                completion(imageURL)
            }
        }
    }
    
    func updateBio(bio: String) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.users.document(currentUserID).updateData(["bio" : bio]) { error in
            if let error = error {
                print("DEBUG: Error updating user bio: \(error.localizedDescription)")
            }
            AuthViewModel.shared.fetchCurrentUser()
        }
    }
    
}
