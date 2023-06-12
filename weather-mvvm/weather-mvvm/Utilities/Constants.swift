//
//  Constants.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 09.06.2023..
//

import Foundation

struct Constants {
    static func urlForCity(city: String) -> URL {
        let userDefaults = UserDefaults.standard
        let unit = userDefaults.value(forKey: "unit") as? String ?? "metric"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&id=524901&appid=0c44e36b3412b4f92677559a9583e7c3&units=\(unit)") else {
            fatalError("Invalid URL")
        }
        
        return url
    }
}
