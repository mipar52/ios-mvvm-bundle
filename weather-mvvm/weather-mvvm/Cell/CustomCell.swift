//
//  CustomWeatherCell.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import UIKit
import SnapKit

class CustomWeatherCell: UITableViewCell {

    var weatherVM : WeatherViewModel?
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = weatherVM?.city ?? "Split"
        label.font = label.font.withSize(32)
        label.adjustsFontSizeToFitWidth = true
        label.tintColor = .black
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = weatherVM?.country ?? "HR"
        label.font = label.font.withSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.tintColor = .black
        return label
    }()
    
    private lazy var cityInfoVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, countryLabel])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Current: \(weatherVM?.temparature ?? 0.0)°"
        label.font = label.font.withSize(32)
        label.adjustsFontSizeToFitWidth = true
        label.tintColor = .black
        label.textAlignment = .right
        return label
    }()

    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Max: \(weatherVM?.maximumTemparature ?? "0.0")°"
        label.font = label.font.withSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.tintColor = .black
        label.textAlignment = .right
        return label
    }()
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Min: \(weatherVM?.minimumTemparature ?? "0.0")°"
        label.font = label.font.withSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.tintColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var tempInfoVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tempLabel, maxTempLabel, minTempLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        return stack
    }()

        
    private lazy var horizontalStack: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [cityInfoVStack, tempInfoVStack])
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.spacing = 16
        return hStack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    convenience init (city: String? = nil, tempature: String? = nil) {
//        self.city = city
//        self.tempature = tempature
//        self.layout()
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        layout()
    }
}

extension CustomWeatherCell {
    private func layout() {
        self.addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { make in
            //make.top.equalToSuperview()
            make.top.equalTo(self.snp.topMargin).offset(16)
            make.bottom.equalTo(self.snp.bottomMargin).offset(-16)
            make.leading.equalTo(self.snp.leadingMargin).offset(16)
            make.trailing.equalTo(self.snp.trailingMargin).offset(-16)
        }
        
        cityInfoVStack.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
//            make.topMargin.equalToSuperview().offset(16)
//            make.bottomMargin.equalToSuperview().offset(-16)
//            make.leadingMargin.equalTo(self.snp.leadingMargin).offset(16)
        }
        
        tempInfoVStack.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()

//            make.topMargin.equalToSuperview().offset(16)
//            make.bottomMargin.equalToSuperview().offset(-16)
//            make.trailingMargin.equalToSuperview().offset(-16)
        }
        
        
        cityLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(20)
        }

        countryLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
//
//
//        tempLabel.snp.makeConstraints { make in
//            make.height.equalTo(30)
//            make.width.equalTo(20)
//        }

//        maxTempLabel.snp.makeConstraints { make in
//            make.height.equalTo(10)
//            make.width.equalTo(15)
//        }
//
//        minTempLabel.snp.makeConstraints { make in
//            make.height.equalTo(10)
//            make.width.equalTo(15)
//        }

    }
}
