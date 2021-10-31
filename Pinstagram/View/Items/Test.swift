//
//  Test.swift
//  Pinstagram
//
//  Created by Robert Pelka on 31/10/2021.
//

import SwiftUI

struct Test: View {
    @State var spin = false
    
    var body: some View {
        Rectangle()
            .frame(width: 64, height: 64)
            .rotationEffect(.degrees(spin ? 360: 0))
            .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false))
            .onAppear() {
                self.spin.toggle()
            }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
