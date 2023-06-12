//
//  CityPickViewModel.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import Foundation

struct AddNewCityViewModel {
    
    func addCity(city: String, completion: @escaping (WeatherViewModel) -> Void) {
        let weatherURL = Constants.urlForCity(city: city)
        let weatherResouce = Resource<WeatherResponse>(url:weatherURL)
        
        WeatherAPIService().loadWeather(resource: weatherResouce) { result in
            switch result {
            case .success(let response):
                completion(WeatherViewModel(weatherResponse: response))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
