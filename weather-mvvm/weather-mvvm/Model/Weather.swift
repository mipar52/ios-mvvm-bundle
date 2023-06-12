//
//  Weather.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: MainTempatureInformation
    let sys: SystemInfo
    let name: String
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct MainTempatureInformation: Decodable {
    let tempature: Double
    let minimumTempature: Double
    let maximumTempature: Double
    let humidity: Double
    
    private enum CodingKeys: String, CodingKey {
    case tempature = "temp"
    case minimumTempature = "temp_min"
    case maximumTempature = "temp_max"
    case humidity
    }
}

struct SystemInfo: Decodable {
    let country: String
}
