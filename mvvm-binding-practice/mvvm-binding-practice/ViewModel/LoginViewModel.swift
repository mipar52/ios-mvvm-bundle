//
//  LoginViewModel.swift
//  mvvm-binding-practice
//
//  Created by Milan Parađina on 12.06.2023..
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(callback: @escaping (T) -> Void) {
        self.listener = callback
    }
}

struct LoginViewModel {
    var username = Dynamic("")
    var password = Dynamic("")
}
