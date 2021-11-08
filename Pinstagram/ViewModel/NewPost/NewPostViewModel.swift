//
//  NewPostViewModel.swift
//  Pinstagram
//
//  Created by Robert Pelka on 08/11/2021.
//

import Foundation
import SwiftUI
import MapKit

enum LocationDescriptionType {
    case country, city, flag, comma
}

class NewPostViewModel: ObservableObject {
    @Published var placeDescription = ""
    
    func getLocationDescription(fromCoordinate coordinate: CLLocationCoordinate2D?, types: [LocationDescriptionType]) {
        getPlacemark(fromCoordinate: coordinate) { placemark in
            guard let placemark = placemark else { return }
            
            self.placeDescription = ""
            for type in types {
                switch type {
                case .city:
                    self.placeDescription += placemark.locality ?? ""
                case .country:
                    self.placeDescription += placemark.country ?? ""
                case .flag:
                    self.placeDescription += self.countryFlag(isoCountryCode: placemark.isoCountryCode) ?? ""
                case .comma:
                    self.placeDescription += ", "
                }
            }
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
