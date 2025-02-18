//
//  OrderCompleteView.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct OrderCompleteView: View {
    @Binding var path: NavigationPath  // Binding to modify the navigation path
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.brown)
                .padding()
            
            Text("Order Complete!")
                .font(Themes.titleFont)
                .fontWeight(.bold)
            
            Text("Thank you for your order. \nIt is being processed and will be ready soon.")
                .multilineTextAlignment(.center)
                .padding()
                .font(Themes.bodyFont)
            
            Spacer()
            
            Button("Back To Main Page") {
//                path.removeLast(path.count)
                path = NavigationPath()
            }
            .padding()
            .buttonStyle(Buttons())
        }
        .padding()
        .tint(Color(Themes.primary)) // Use a custom color from Assets
    }
}

#Preview {
    OrderCompleteView(path: .constant(NavigationPath()))
}
