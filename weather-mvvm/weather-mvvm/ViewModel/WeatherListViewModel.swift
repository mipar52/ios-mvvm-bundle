//
//  WeatherListViewModel.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import Foundation

struct WeatherListViewModel {
   private var weathersVM: [WeatherViewModel] = [WeatherViewModel]()
}

extension WeatherListViewModel {
    
    var numberOfVMs: Int {
        return weathersVM.count
    }

    mutating func addViewModel(_ vm: WeatherViewModel) {
        weathersVM.append(vm)
    }

    func getViewModel(_ index: Int) -> WeatherViewModel {
        return weathersVM[index]
    }
    
    mutating func updateTempUnit(to tempatureUnit: Tempature) {
        switch tempatureUnit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
}
extension WeatherListViewModel {
    
    private mutating func toCelsius() {
       weathersVM =  weathersVM.map { vm in
           var weatherVM = vm
           weatherVM.temparature = ((weatherVM.temparature - 32) * 5/9)
           return weatherVM
        }
    }
    
    private mutating func toFahrenheit() {
       weathersVM =  weathersVM.map { vm in
           var weatherVM = vm
           weatherVM.temparature = (weatherVM.temparature * 5/9) + 32
           return weatherVM
        }
    }
}
