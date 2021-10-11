//
//  SearchBar.swift
//  Pinstagram
//
//  Created by Robert Pelka on 11/10/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Color(.systemGray6)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.systemGray2))
                    TextField("Search...", text: $searchText)
                        .onTapGesture {
                            isEditing = true
                        }
                }
                .padding(.leading, 10)
            }
            .cornerRadius(5)
            .animation(.easeOut)
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.primary)
                        .padding(.horizontal, 5)
                })
                .transition(.move(edge: .trailing))
                .animation(.easeOut)
            }
        }
        .frame(height: 46)
        .padding(.horizontal, 10)
        .padding(.top, 15)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), isEditing: .constant(false))
    }
}
