//
//  NotificationsView.swift
//  Pinstagram
//
//  Created by Robert Pelka on 09/10/2021.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    if viewModel.notifications.isEmpty {
                        Text("No notifications yet.")
                            .padding(.top, 25)
                    }
                    else {
                        ForEach(viewModel.notifications) { notification in
                            NotificationCell(viewModel: NotificationCellViewModel(notification: notification))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                        }
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
