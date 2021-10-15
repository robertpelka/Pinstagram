//
//  NotificationsView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(1..<10) { _ in
                        NotificationCell(type: .like)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                }
            }
            .padding(.top, 10)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
