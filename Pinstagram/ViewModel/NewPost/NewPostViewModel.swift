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
    @Published var code: String?
    
    func uploadPost(image: UIImage, description: String, coordinate: CLLocationCoordinate2D, city: String, country: String, flag: String, code: String, completion: @escaping () -> ()) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        let postID = UUID().uuidString
        
        ImageUploader.uploadImage(image: image, fileName: postID, type: .post) { imageURL in
            let post = Post(id: postID, image: imageURL, description: description, ownerID: currentUserID, timestamp: Timestamp(date: Date()), longitude: coordinate.longitude, latitude: coordinate.latitude, city: city, country: country, flag: flag)
            do {
                try K.Collections.posts.document(postID).setData(from: post)
            }
            catch let error {
                print("DEBUG: Error uploading post data: \(error.localizedDescription)")
                return
            }
            self.updateNumberOfVisitedCountries(withCountryCode: code)
            completion()
        }
    }
    
    func getLocationDescription(fromCoordinate coordinate: CLLocationCoordinate2D?) {
        self.city = nil
        self.country = nil
        self.flag = nil
        self.code = nil
        
        getPlacemark(fromCoordinate: coordinate) { placemark in
            guard let placemark = placemark else { return }
            guard let city = placemark.locality, let country = placemark.country, let flag = self.countryFlag(isoCountryCode: placemark.isoCountryCode), let code = placemark.isoCountryCode else { return }
            self.city = city
            self.country = country
            self.flag = flag
            self.code = code
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
    
    func updateNumberOfVisitedCountries(withCountryCode code: String) {
        guard let currentUserID = AuthViewModel.shared.currentUser?.id else { return }
        
        K.Collections.visitedCountries.document(currentUserID).collection("countryCodes").document(code).setData([:]) { error in
            if let error = error {
                print("DEBUG: Error adding country code to the list of visited countries: \(error.localizedDescription)")
                return
            }
            K.Collections.visitedCountries.document(currentUserID).collection("countryCodes").getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Error fetching country codes: \(error.localizedDescription)")
                    return
                }
                guard let numberOfVisitedCountries = snapshot?.count else {
                    print("DEBUG: Error getting number of country code documents")
                    return
                }
                K.Collections.users.document(currentUserID).updateData(["visitedCountries" : numberOfVisitedCountries]) { error in
                    if let error = error {
                        print("DEBUG: Error updating number of visited countries: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
    
}
