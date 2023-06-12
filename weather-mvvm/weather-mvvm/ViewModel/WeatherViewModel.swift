//
//  WeatherViewModel.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import Foundation

struct WeatherViewModel {
    let weatherResponse: WeatherResponse
    var temparature: Double
    
    init(weatherResponse: WeatherResponse) {
        self.weatherResponse = weatherResponse
        temparature = weatherResponse.main.tempature
    }
}

extension WeatherViewModel {
    var country: String {
        return weatherResponse.sys.country
    }
    var city: String {
        return weatherResponse.name
    }
        
    var maximumTemparature: String {
        return "\(weatherResponse.main.maximumTempature)"
    }
    
    var minimumTemparature: String {
        return "\(weatherResponse.main.minimumTempature)"
    }
}
