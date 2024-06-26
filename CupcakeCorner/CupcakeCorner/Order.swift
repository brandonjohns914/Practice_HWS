//
//  Order.swift
//  CupcakeCorner
//
//  Created by Brandon Johns on 3/25/24.
//

import Foundation
import SwiftUI

@Observable
class Order: Codable {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var extraFrosting = false
    var addSprinkles = false
    
    
    var specialRequstEnabled = false {
        didSet {
            if specialRequstEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true 
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
   
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
}
