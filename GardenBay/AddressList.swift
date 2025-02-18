//
//  AddressList.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import Foundation
import SwiftUI

class AddressList: ObservableObject {
    @AppStorage("recentOrders") private var storedOrders: Data?

    @Published var orders: [Order] = []

    init() {
        loadOrders()
    }

    func addOrder(_ order: Order) {
        
        // Remove the existing order if it has the same details
        orders.removeAll { existingOrder in
                existingOrder.name == order.name &&
                existingOrder.streetAddress == order.streetAddress &&
                existingOrder.city == order.city &&
                existingOrder.zip == order.zip
            }

        // Add the new order to the top of the list
        orders.insert(order, at: 0)

        // Keep only 10 orders in the list
        if orders.count > 10 {
            orders.removeLast()
        }

        // Save the updated list
        saveOrders()
    }

    private func loadOrders() {
        guard let storedOrders else { return }
        if let decoded = try? JSONDecoder().decode([Order].self, from: storedOrders) {
            orders = decoded
        }
    }

    private func saveOrders() {
        if let encoded = try? JSONEncoder().encode(orders) {
            storedOrders = encoded
        }
    }
}
