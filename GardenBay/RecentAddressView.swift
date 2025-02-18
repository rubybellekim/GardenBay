//
//  RecentAddressView.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct RecentAddressView: View {
    let addressList: AddressList
    var onSelect: (Order) -> Void  // Callback when an address is selected

    var body: some View {
        NavigationStack {
            Text("Saved up to 10 recent addresses.")
            List(addressList.orders) { order in
                Button {
                    onSelect(order)  // Send selected address back
                } label: {
                    VStack(alignment: .leading) {
                        Text(order.name).font(.headline)
                        Text(order.streetAddress)
                        Text("\(order.city), \(order.zip)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Recent Addresses")
            .tint(Color(Themes.primary)) // Use a custom color from Assets
            .font(Themes.bodyFont)
        }
    }
}

#Preview {
    RecentAddressView(addressList: AddressList()) { _ in }
}
