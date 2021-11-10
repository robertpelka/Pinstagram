//
//  NewPostViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 08/11/2021.
//

import Foundation
import SwiftUI
import MapKit
import Firebase

class NewPostViewModel: ObservableObject {
    @Published var city: String?
    @Published var country: String?
    @Published var flag: String?
    
    func uploadPost(image: UIImage, coordinate: CLLocationCoordinate2D, city: String, country: String, flag: String, completion: @escaping () -> ()) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        let postID = UUID().uuidString
        
        ImageUploader.uploadImage(image: image, fileName: postID, type: .post) { imageURL in
            let post = Post(id: postID, image: imageURL, ownerID: currentUserID, timestamp: Timestamp(date: Date()), longitude: coordinate.longitude, latitude: coordinate.latitude, city: city, country: country, flag: flag)
            do {
                try K.Collections.posts.document(postID).setData(from: post)
            }
            catch let error {
                print("DEBUG: Error uploading post data: \(error.localizedDescription)")
                return
            }
            completion()
        }
    }
    
    func getLocationDescription(fromCoordinate coordinate: CLLocationCoordinate2D?) {
        self.city = nil
        self.country = nil
        self.flag = nil
        
        getPlacemark(fromCoordinate: coordinate) { placemark in
            guard let placemark = placemark else { return }
            guard let city = placemark.locality, let country = placemark.country, let flag = self.countryFlag(isoCountryCode: placemark.isoCountryCode) else { return }
            self.city = city
            self.country = country
            self.flag = flag
        }
    }
    
    func getPlacemark(fromCoordinate coordinate: CLLocationCoordinate2D?, completion: @escaping (CLPlacemark?) -> Void) {
        guard let coordinate = coordinate else { return }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("DEBUG: Error reversing geocode location: \(error.localizedDescription)")
                return
            }
            let placemark = placemarks?.first
            completion(placemark)
        }
    }
    
    func countryFlag(isoCountryCode: String?) -> String? {
        guard let isoCountryCode = isoCountryCode else { return nil }
        let base = 127397
        var tempScalarView = String.UnicodeScalarView()
        for i in isoCountryCode.utf16 {
            if let scalar = UnicodeScalar(base + Int(i)) {
                tempScalarView.append(scalar)
            }
        }
        
        return " " + String(tempScalarView)
    }
    
}
