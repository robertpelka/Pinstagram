//
//  ImageUploader.swift
//  Pinstagram
//
//  Created by Robert Pelka on 04/11/2021.
//

import Foundation
import UIKit
import Firebase

enum uploadType: String {
    case profileImage = "profilePictures/"
    case post = "postImages/"
}

struct ImageUploader {
    static func uploadImage(image: UIImage, fileName: String, type: uploadType, completion: @escaping (String) -> Void) {
        let imageRef = Storage.storage().reference().child(type.rawValue + fileName + ".jpeg")
        guard let image = image.jpegData(compressionQuality: 0.5) else {
            print("DEBUG: Error converting UIImage to jpeg.")
            return
        }
        imageRef.putData(image, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Error uploading image: \(error.localizedDescription)")
                return
            }
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: Error getting image url: \(error.localizedDescription)")
                    return
                }
                guard let url = url?.absoluteString else {
                    print("DEBUG: Error converting URL to String.")
                    return
                }
                completion(url)
            }
        }
    }
}
