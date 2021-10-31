//
//  CustomProgressStyle.swift
//  Pinstagram
//
//  Created by Robert Pelka on 31/10/2021.
//

import SwiftUI

struct CustomProgressStyle: ProgressViewStyle {
    var size: Double
    @State var isAnimating = false
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .stroke(AngularGradient(colors: [Color(white: 1, opacity: 0), Color.white], center: .center, startAngle: .zero, endAngle: .degrees(270)), style: StrokeStyle(lineWidth: CGFloat(size/5)))
            .frame(width: size, height: size)
            .rotationEffect(Angle.degrees(isAnimating ? 360 : 0))
            .animation(.linear(duration: 0.75).repeatForever(autoreverses: false))
            .onAppear() {
                self.isAnimating = true
            }
    }
}

struct CustomProgressStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [K.Colors.primary, Color(red: 158/255, green: 154/255, blue: 43/255), Color(red: 185/255, green: 77/255, blue: 16/255)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CustomProgressStyle(size: 32))
        }
    }
}
