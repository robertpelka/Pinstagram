//
//  NewPostView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct NewPostView: View {
    @State var description = "Description..."
    @State var isEdited = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Image("postImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85)
                        .clipped()
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
                
                Group {
                    Text("Detected place: ")
                        .font(.system(size: 16, weight: .regular))
                        +
                        Text("Paris, France 🇫🇷")
                        .font(.system(size: 16, weight: .medium))
                }
                .padding()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Add Post")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 38)
                        .background(Color(red: 43/255, green: 158/255, blue: 110/255))
                        .cornerRadius(5)
                        .padding(.top)
                })

                Spacer()
            }
            .padding()
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
