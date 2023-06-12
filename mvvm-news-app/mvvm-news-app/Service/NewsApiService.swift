//
//  NewsApiService.swift
//  mvvm-news-app
//
//  Created by Milan Parađina on 18.05.2023..
//

import Foundation

class NewsApiService {
    
    func getArticles(url: String) async throws -> Result<ArticleList, NetworkError> {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                let httpReponse = response as? HTTPURLResponse
                
                if let httpReponse = httpReponse {
                    switch httpReponse.statusCode {
                    case 200...299:
                        let result = try JSONDecoder().decode(ArticleList.self, from: data)
                        return .success(result)
                    case 400...499:
                        return .failure(NetworkError.invalidUrl)
                    case 500...599:
                        return .failure(NetworkError.invalidUrl)
                    default:
                        return .failure(NetworkError.invalidUrl)
                    }
                }
            } catch {
                print(error)
                return .failure(NetworkError.invalidUrl)//.decode(value: error.localizedDescription))
            }
             return .failure(NetworkError.invalidUrl)
        }
        else {
            throw NetworkError.invalidUrl
        }
    }
}
