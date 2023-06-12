//
//  OrderViewModel.swift
//  orders-mvvm
//
//  Created by Milan Parađina on 06.06.2023..
//

import Foundation

struct OrderListViewModel {
    var orderViewModels: [OrderViewModel]
}

extension OrderListViewModel {
    
    init() {
        self.orderViewModels = [OrderViewModel]()
    }
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.orderViewModels[index]
    }
}

struct OrderViewModel {
     let order: Order
}

extension OrderViewModel {
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
