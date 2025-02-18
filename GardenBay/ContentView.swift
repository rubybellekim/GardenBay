//
//  ContentView.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
        
    var body: some View {
            VStack {
                NavigationStack(path: $path) {
                    VStack {
                        Text("{ Garden Bay }")
                            .font(Themes.largeTitleFont)
                            .fontWeight(.bold)
                            .foregroundColor(Themes.primary)
                        
                        Image("flower_bird")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                        Text("Flowers whisper what words cannot. \nShare the joy, plant a dream.")
                            .font(Themes.bodyFont)
                            .padding()
                        NavigationLink("Start Order", value: "Order")
                            .buttonStyle(Buttons())

                    }
                    .navigationDestination(for: String.self) { value in
                        if value == "Order" {
                            OrderView(path: $path)
                        }
                    }
                }
            }
            .preferredColorScheme(.light)
        }
}

#Preview {
    ContentView()
}
