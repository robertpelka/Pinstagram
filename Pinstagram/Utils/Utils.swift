//
//  Utils.swift
//  Pinstagram
//
//  Created by Robert Pelka on 17/10/2021.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
