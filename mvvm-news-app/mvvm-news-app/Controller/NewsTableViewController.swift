//
//  NewsTableViewController.swift
//  mvvm-news-app
//
//  Created by Milan Parađina on 18.05.2023..
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let articleListVM = articleListVM {
            return articleListVM.numberOfSections
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articleListVM = articleListVM {
            return articleListVM.numberOfRowsInSection(section)
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let articleVM = articleListVM!.articleAtIndex(indexPath.row) //articleListVM.articles
        
        cell.textLabel?.text = articleVM.title
        cell.detailTextLabel?.text = articleVM.description

        return cell
    }
}

extension NewsTableViewController {
    private func setup() {
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Some news"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .blue
    }
    
    private func getArticles() {
        Task {
            do {
                let service = try await NewsApiService().getArticles(url: "https://newsapi.org/v2/everything?q=apple&from=2023-05-17&to=2023-05-17&sortBy=popularity&apiKey=989c96ca9d3e4e8e82f230386e87f156")
                switch service {
                case .success(let articles):
                    articleListVM = ArticleListViewModel(articles: articles.articles)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let failure):
                    print(failure)
                }

            } catch {
                print(error)
            }
        }

    }
}
