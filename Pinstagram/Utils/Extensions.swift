//
//  Extensions.swift
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

extension UIImage {
    func resize(maxSideLength: CGFloat) -> UIImage {
        let aspectRatio = self.size.width / self.size.height
        let newWidth: CGFloat
        let newHeight: CGFloat
        
        if self.size.width > self.size.height {
            newWidth = maxSideLength
            newHeight = maxSideLength / aspectRatio
        }
        else {
            newHeight = maxSideLength
            newWidth = maxSideLength * aspectRatio
        }
        
        if newWidth < self.size.width {
            let newSize = CGSize(width: newWidth, height: newHeight)
            
            let image = UIGraphicsImageRenderer(size: newSize).image { _ in
                draw(in: CGRect(origin: .zero, size: newSize))
            }
            return image.withRenderingMode(renderingMode)
        }
        else {
            return self
        }
    }
}
