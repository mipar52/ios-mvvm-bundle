//
//  ArticleViewModel.swift
//  mvvm-news-app
//
//  Created by Milan Parađina on 18.05.2023..
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
    
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

struct ArticleViewModel {
    private let ariticle: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.ariticle = article
    }
}

extension ArticleViewModel {
    var title: String {
        return self.ariticle.title
    }
    
    var description: String {
        return self.ariticle.description
    }
}
