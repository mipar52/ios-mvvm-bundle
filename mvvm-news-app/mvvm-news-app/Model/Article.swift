//
//  Article.swift
//  mvvm-news-app
//
//  Created by Milan Parađina on 18.05.2023..
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
    
}
struct Article: Decodable {
    let title: String
    let description: String
}
