//
//  OrderView.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct OrderView: View {
    @State private var order = Order()
    @Binding var path: NavigationPath  // Binding to modify the navigation path

    var body: some View {
        Form {
            Section {
                Picker("Select Flowers", selection: $order.type) {
                    ForEach(Order.types.indices, id: \.self) {
                        Text(Order.types[$0])
                    }
                }
                Picker("Select Size", selection: $order.size) {
                    ForEach(Order.sizes.indices, id: \.self) {
                        Text(Order.sizes[$0])
                    }
                }
            }
            
            Section {
                Toggle("Any Special Add-ons?", isOn: $order.specialRequestEnabled.animation())
                
                if order.specialRequestEnabled {
                    Toggle("3 Mylar Balloons (+$9.99)", isOn: $order.balloons)
                    Toggle("Mini Stuffed Bear (+$17.99)", isOn: $order.miniBear)
                    Toggle("Box Of Chocolates (+$24.99)", isOn: $order.chocolates)
                }
            }
            
            Section {
                NavigationLink("Delivery Option") {
                    AddressView(order: order, addressList: AddressList(), path: $path)
                }
            }
        }
        .navigationTitle("Garden Bay")
        
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color(Themes.primary)) // Use a custom color from Assets
        .font(Themes.bodyFont)
        
        Text("Total: $\(order.cost, specifier: "%.2f")")
            .font(Themes.bodyFont)
            .foregroundColor(Themes.primary)
    }
}

#Preview {
    OrderView(path: .constant(NavigationPath()))
}
