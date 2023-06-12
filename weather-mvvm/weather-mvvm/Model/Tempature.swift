//
//  Tempature.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import Foundation

enum Tempature: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Tempature {
    var displayName: String {
        get {
            switch(self) {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}
