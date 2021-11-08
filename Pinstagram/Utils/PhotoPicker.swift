//
//  PhotoPicker.swift
//  Pinstagram
//
//  Created by Robert Pelka on 02/11/2021.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var coordinate: CLLocationCoordinate2D?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let error = error {
                            print("DEBUG: Error loading a photo: \(error.localizedDescription)")
                        }
                        else {
                            self.parent.image = image as? UIImage
                        }
                    }
                }
                
                if let assetID = result.assetIdentifier {
                    let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil)
                    self.parent.coordinate = assetResults.firstObject?.location?.coordinate
                }
                else {
                    self.parent.coordinate = nil
                    print("DEBUG: Error getting asset identifier.")
                }
            }
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

