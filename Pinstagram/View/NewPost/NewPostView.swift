//
//  NewPostView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Binding var tabSelection: Int
    @State var selectedImage: UIImage?
    @State var coordinate: CLLocationCoordinate2D?
    @State var description = "Description..."
    @State var isEdited = false
    
    @ObservedObject var viewModel = NewPostViewModel()
    
    @State private var shouldShowAlert = false
    @State var errorMessage: String?
    @State var requestAuthorizationStatus: PHAuthorizationStatus?
    
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
                        viewModel.getLocationDescription(fromCoordinate: coordinate)
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
                
                if requestAuthorizationStatus == .denied {
                    Text("Please grant access to the photos.")
                        .font(.system(size: 16, weight: .regular))
                        .padding()
                }
                else {
                    if let city = viewModel.city, let country = viewModel.country, let flag = viewModel.flag {
                        Group {
                            Text("Detected place: ")
                                .font(.system(size: 16, weight: .regular))
                            +
                            Text(city + ", " + country + flag)
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding(.vertical)
                    }
                    else {
                        Text("Detected place: ")
                            .font(.system(size: 16, weight: .regular))
                        +
                        Text("None")
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                
                Button(action: {
                    guard let image = selectedImage else {
                        shouldShowAlert = true
                        errorMessage = "Press plus button to add a picture."
                        return
                    }
                    guard let coordinate = coordinate, let city = viewModel.city, let country = viewModel.country, let flag = viewModel.flag else {
                        shouldShowAlert = true
                        errorMessage = "We can not determine where the photo was taken."
                        return
                    }
                    if !isEdited || description == "" {
                        shouldShowAlert = true
                        errorMessage = "Please add description."
                    }
                    else {
                        isLoading = true
                        isButtonDisabled = true
                        viewModel.uploadPost(image: image, coordinate: coordinate, city: city, country: country, flag: flag) {
                            self.coordinate = nil
                            self.selectedImage = nil
                            self.description = "Description..."
                            self.isEdited = false
                            self.isLoading = false
                            self.isButtonDisabled = false
                            self.tabSelection = 4
                        }
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
                requestAuthorizationStatus = status
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(tabSelection: .constant(0))
    }
}
