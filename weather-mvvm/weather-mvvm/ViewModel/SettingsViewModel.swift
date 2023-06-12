//
//  SettingsViewModel.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import Foundation

struct SettingsViewModel {
    
    let temparatures = Tempature.allCases

    var selectedTemparature: Tempature {
        get {
            let ud = UserDefaults.standard
            var unitValue = ""
            if let value = ud.value(forKey: "unit") as? String {
                unitValue = value
            }
            return Tempature(rawValue: unitValue)!
        }
        set {
            let ud = UserDefaults.standard
            ud.set(newValue.rawValue, forKey: "unit")
        }
    }
}
