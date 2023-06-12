//
//  LoginViewController.swift
//  mvvm-binding-practice
//
//  Created by Milan Parađina on 12.06.2023..
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private var loginVM = LoginViewModel()
    
    lazy var emailTextField: BindingTextField = {
        let tf = BindingTextField()
        tf.placeholder = "Your e-mail"
        tf.backgroundColor = .lightGray
        tf.keyboardType = .emailAddress
        tf.bind { [weak self] text in
            self?.loginVM.username.value = text
        }
        return tf
    }()
    
    lazy var passwordTextField: BindingTextField = {
        let tf = BindingTextField()
        tf.placeholder = "Your e-mail"
        tf.backgroundColor = .lightGray
        tf.isSecureTextEntry = true
        tf.bind { [weak self] password in
            self?.loginVM.password.value = password
        }
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var fetchLoginInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch login info", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(fetchLoginInfo(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [emailTextField,
                                                    passwordTextField,
                                                    loginButton,
                                                   fetchLoginInfoButton])
        vStack.axis = .vertical
        vStack.spacing = 16
        return vStack
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
}
extension LoginViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        fetchLoginInfoButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
        }

    }
    
    private func bind() {
        loginVM.username.bind { [weak self] text in
            self?.emailTextField.text = text
        }
        loginVM.password.bind { [weak self] text in
            self?.passwordTextField.text = text
        }
    }

    @objc private func login(_ sender: UIButton) {
        print("Logged in!")
        print("Email: \(loginVM.username.value), password: \(loginVM.password.value)")
    }
    
    @objc private func fetchLoginInfo(_ sender: UIButton) {
        print("Fetching dummy info...")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.loginVM.username.value = "joseph@gmail.com"
            self?.loginVM.password.value = "admin"
        }
    }
}
