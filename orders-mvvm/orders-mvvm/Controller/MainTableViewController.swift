//
//  MainTableViewController.swift
//  orders-mvvm
//
//  Created by Milan Parađina on 24.05.2023..
//

import UIKit

class MainTableViewController: UITableViewController {
//https://warp-wiry-rugby.glitch.me/orders -> GET
//https://warp-wiry-rugby.glitch.me/orders -> POST
//https://warp-wiry-rugby.glitch.me/clear-orders -> DELETE

    var orderListViewModel = OrderListViewModel()
    weak var delegate: AddCoffeeOrderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addAddItem()
        populateOrders()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavController()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.orderViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mainCell")
        let vm = orderListViewModel.orderViewModel(at: indexPath.row)
        
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        
        return cell
    }
}
extension MainTableViewController {
    private func setupNavController() {
        self.navigationController?.navigationBar.topItem?.title = "Orders to serve"
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .brown
    }
    
    private func addAddItem() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addAction(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }
    
    @objc func addAction(_ sender: UIBarButtonItem) {
        let ordersVC = OrderListTableViewController()
        ordersVC.delegate = self
        
        self.navigationController?.pushViewController(ordersVC, animated: true)
    }
    
    private func populateOrders() {
        
        NetworkService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.orderViewModels = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension MainTableViewController: AddCoffeeOrderDelegate {
    func viewControllerDidPressSave() {
        self.populateOrders()
    }
}
