//
//  SettingsViewController.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 07.06.2023..
//

import UIKit

protocol TempUnitChangeDelegate: AnyObject {
    func didChangeUnit(vm: SettingsViewModel)
}

class SettingsViewController: UIViewController {

    var settingsVM = SettingsViewModel()
    weak var delegate: TempUnitChangeDelegate?
    
    private lazy var tempaturePickLabel : UILabel = {
        let label = UILabel()
        label.text = "Tempature unit displayed:"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var segmentTempaturePicker: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: settingsVM.temparatures.map({$0.displayName}))
        segmentControl.selectedSegmentIndex = (UserDefaults.standard.string(forKey: "unit") == "metric" ? 0 : 1)
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentControl
    }()
    
    private lazy var horizontalStack : UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [tempaturePickLabel, segmentTempaturePicker])
        hStack.axis = .horizontal
        hStack.spacing = 16
        hStack.distribution = .fillEqually
        return hStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
}

extension SettingsViewController {
    private func layout() {
        self.navigationItem.title = "App settings"
        view.addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        tempaturePickLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        segmentTempaturePicker.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        settingsVM.selectedTemparature = Tempature.allCases[sender.selectedSegmentIndex]
        delegate?.didChangeUnit(vm: settingsVM)
    }
}
