//
//  BindingTextField.swift
//  mvvm-binding-practice
//
//  Created by Milan Parađina on 12.06.2023..
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChanged: (String) -> Void = {_ in}
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        if let text = sender.text {
            textChanged(text)
        }
    }
}
