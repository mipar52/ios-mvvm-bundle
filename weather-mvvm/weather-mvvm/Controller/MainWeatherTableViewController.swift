//
//  MainWeatherTableViewController.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import UIKit

class MainWeatherTableViewController: UITableViewController {
//°C
//°F
    private var weatherListVM = WeatherListViewModel()
    private var lastSelectionUnit : Tempature!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationButtons()
        self.tableView.register(CustomWeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        
        if let value = UserDefaults.standard.value(forKey: "unit") as? String {
            lastSelectionUnit = Tempature(rawValue: value)!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavController()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListVM.numberOfVMs
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CustomWeatherCell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! CustomWeatherCell
        let vm = weatherListVM.getViewModel(indexPath.row)
        
        cell.weatherVM = vm
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension MainWeatherTableViewController {
    private func setupNavController() {
        self.navigationController?.navigationBar.topItem?.title = "Weather"
        self.navigationController?.navigationBar.backgroundColor = .cyan
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addNavigationButtons() {
        
        let addCityButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(goToCityVC(_:)))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(goToSettingsVC(_:)))
        
        self.navigationItem.rightBarButtonItem = addCityButton
        self.navigationItem.leftBarButtonItem = settingsButton
    }
    
    @objc private func goToCityVC(_ sender: UIBarButtonItem) {
        let vc = CityPickViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToSettingsVC(_ sender: UIBarButtonItem) {
        let vc = SettingsViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainWeatherTableViewController: AddWeatherDelegate {
    func didPressAddCity(viewModel: WeatherViewModel) {
        weatherListVM.addViewModel(viewModel)
        tableView.reloadData()
    }
}
extension MainWeatherTableViewController: TempUnitChangeDelegate {
    func didChangeUnit(vm: SettingsViewModel) {
        
        if lastSelectionUnit.rawValue != vm.selectedTemparature.rawValue {
            self.weatherListVM.updateTempUnit(to: Tempature(rawValue: vm.selectedTemparature.rawValue) ?? Tempature.celsius)
            lastSelectionUnit = Tempature(rawValue: vm.selectedTemparature.rawValue)!
            tableView.reloadData()
        }
    }
}
