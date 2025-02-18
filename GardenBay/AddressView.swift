//
//  AddressView.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @ObservedObject var addressList: AddressList  // Change @Binding to @ObservedObject
    @State private var showingSheet = false
    
    @Binding var path: NavigationPath  // Binding to modify the navigation path

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check Out") {
                    CheckoutView(order: order, addressList: AddressList(), path: $path)
                }
            }
            .disabled(order.hasValidAddress == false)
            
            Section {
                Button("Address Book") {
                    showingSheet = true
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            RecentAddressView(addressList: addressList) { selectedAddress in
                order.name = selectedAddress.name
                order.streetAddress = selectedAddress.streetAddress
                order.city = selectedAddress.city
                order.zip = selectedAddress.zip
                showingSheet = false
            }
        }
        
        .tint(Color(Themes.primary)) // Use a custom color from Assets
        .font(Themes.bodyFont)
        
    }
}



#Preview {
    AddressView(order: Order(), addressList: AddressList(), path: .constant(NavigationPath()))
}
