//
//  AddOrderViewModel.swift
//  orders-mvvm
//
//  Created by Milan Parađina on 06.06.2023..
//

import Foundation

struct AddOrderViewModel {
    
    var name: String?
    var email: String?
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map({$0.rawValue.capitalized})
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map({$0.rawValue.capitalized})
    }
}
