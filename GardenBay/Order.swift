//
//  Order.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//
import Foundation

@Observable
class Order: Codable, Identifiable {
//    @State private var savedName = UserDefaults.standard.string(forKey: "Name")
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _size = "size"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _balloons = "balloons"
        case _miniBear = "miniBear"
        case _chocolates = "chocolates"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Designer Mix", "Pink Themed Blush", "Red Roses Assorted", "Purple Touch Of Lavender", "Pure White Compassion"]
    static let sizes = ["Standard($69.99)", "Deluxe ($79.99)", "Premium ($99.99)", "Luxury ($119.99)"]
    
    var type = 0
    var size = 1
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                balloons = false
                chocolates = false
            }
        }
    }
    var balloons = false
    var miniBear = false
    var chocolates = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var id = UUID()
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        } else if name.hasPrefix(" ") || streetAddress.hasPrefix(" ") || city.hasPrefix(" ") || zip.hasPrefix(" ") {
            return false
        }
        return true
    }
    
    var cost: Double {
        // deluxe price
        var cost = 0.00
        
        switch size {
        case 0:
            cost = 69.99
        case 1:
            cost = 79.99
        case 2:
            cost = 99.99
        case 3:
            cost = 119.99
        default:
            cost = 79.99
        }
        
        //$1 per cake for extra frosting
        if balloons {
            cost += 9.99
        }
        
        if miniBear {
            cost += 17.99
        }
        
        //$0.50 per cake for sprinkles
        if chocolates {
            cost += 24.99
        }
        
        return cost
    }
}
