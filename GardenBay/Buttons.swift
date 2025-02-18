//
//  Buttons.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct Buttons: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Cochin", size: 22))
            .padding()
            .frame(maxWidth: 250, maxHeight: 50)
            .background(Themes.primary)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
