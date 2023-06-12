//
//  CityPickViewController.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import UIKit
import SnapKit

protocol AddWeatherDelegate: AnyObject {
    func didPressAddCity(viewModel: WeatherViewModel)
}

class CityPickViewController: UIViewController {

    private let cityVM = AddNewCityViewModel()
    weak var delegate: AddWeatherDelegate?
    
    private lazy var cityTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a city name"
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add city", for: .normal)
        button.addTarget(self, action: #selector(addCity(_:)), for: .touchUpInside)
        button.tintColor = .black
        button.backgroundColor = .cyan
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [
        cityTextField,
        saveButton])
        vStack.axis = .vertical
        vStack.spacing = 16
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
    }
}

extension CityPickViewController {
    private func layout() {
        self.navigationItem.title = "Add a new city"
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        cityTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
}

extension CityPickViewController {
    @objc private func addCity(_ sender: UIButton) {
        if let searchedCity = cityTextField.text{
            cityVM.addCity(city: searchedCity) { [weak self] weatherVM in
                self?.delegate?.didPressAddCity(viewModel: weatherVM)
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
