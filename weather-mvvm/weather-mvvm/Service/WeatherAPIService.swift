//
//  WeatherAPIService.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 09.06.2023..
//

import Foundation

//API KEY: 0c44e36b3412b4f92677559a9583e7c3
struct WeatherAPIService {
    func loadWeather<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {        
        URLSession.shared.dataTask(with: resource.url) {data, response, error in
            if let data = data, error == nil {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    print(error)
                    completion(.failure(NetworkError.decodeError))
                }
            } else {
                completion(.failure(NetworkError.invalidRequest))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case badURL
    case invalidRequest
    case decodeError
}
