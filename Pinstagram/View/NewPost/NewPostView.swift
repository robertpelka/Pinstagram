//
//  NewPostView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State var selectedImage: UIImage?
    @State var coordinate: CLLocationCoordinate2D?
    @State var description = "Description..."
    @State var isEdited = false
    
    @ObservedObject var viewModel = NewPostViewModel()
    
    @State private var shouldShowAlert = false
    @State var errorMessage: String?
    @State var locationText = "Detected place: "
    
    @State var isPickerPresented = false
    
    @State var isLoading = false
    @State var isButtonDisabled = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Button {
                        isPickerPresented = true
                    } label: {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 85, height: 85)
                                .clipped()
                        }
                        else {
                            Image("addPictureSquare")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 85, height: 85)
                                .clipped()
                        }
                    }
                    .sheet(isPresented: $isPickerPresented) {
                        PhotoPicker(image: $selectedImage, coordinate: $coordinate)
                    }
                    .onChange(of: selectedImage) { _ in
                        viewModel.placeDescription = "None"
                        viewModel.getLocationDescription(fromCoordinate: coordinate, types: [.city, .comma, .country, .flag])
                    }
                    
                    TextEditor(text: $description)
                        .font(.system(size: 16))
                        .frame(height: 85)
                        .onTapGesture {
                            if !isEdited {
                                description = ""
                                isEdited = true
                            }
                        }
                }
                .padding([.top, .horizontal])
                
                Group {
                    Text(locationText)
                        .font(.system(size: 16, weight: .regular))
                    +
                    Text(viewModel.placeDescription)
                        .font(.system(size: 16, weight: .medium))
                }
                .padding()
                
                
                Button(action: {
                    if selectedImage == nil {
                        shouldShowAlert = true
                        errorMessage = "Press plus button to add a picture."
                    }
                    else if !isEdited || description == "" {
                        shouldShowAlert = true
                        errorMessage = "Please add description."
                    }
                    else if coordinate == nil {
                        shouldShowAlert = true
                        errorMessage = "We can not determine where the photo was taken."
                    }
                    else {
                        isLoading = true
                        isButtonDisabled = true
                    }
                }, label: {
                    PrimaryButton(text: "Add Post", isLoading: $isLoading)
                        .padding(.top)
                })
                    .disabled(isButtonDisabled)
                
                Spacer()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(errorMessage ?? "Error"), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .denied {
                    locationText = "Please grant access to the photos."
                }
                else {
                    locationText = "Detected place: "
                }
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
