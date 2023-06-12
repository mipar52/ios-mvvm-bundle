//
//  OrderListTableViewController.swift
//  orders-mvvm
//
//  Created by Milan Parađina on 24.05.2023..
//

import UIKit
import SnapKit

protocol AddCoffeeOrderDelegate: AnyObject {
    func viewControllerDidPressSave()
}

class OrderListTableViewController: UIViewController {

    private var addOrderViewModel = AddOrderViewModel()
    weak var delegate: AddCoffeeOrderDelegate?


    private let tableView : UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private lazy var segmentControll: UISegmentedControl = {
        let sc = UISegmentedControl(items: addOrderViewModel.sizes)
        return sc
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your name"
        return tf
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your e-mail"
        tf.keyboardType = .emailAddress
        return tf
    }()

    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        tableView,
        segmentControll,
        nameTextField,
        emailTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addSaveButton()
        layout()
        dissmissKeyboard()
    }
}

extension OrderListTableViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addOrderViewModel.types.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "coffeeTypeCell")
        let type = addOrderViewModel.types
        
        cell.textLabel?.text = type[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension OrderListTableViewController {
    
    private func addSaveButton() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: self, action: #selector(saveAction(_:)))
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveAction(_ sender: UIBarButtonItem) {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedSize = self.segmentControll.titleForSegment(at: self.segmentControll.selectedSegmentIndex)
        
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Could not get seleted index!")
        }
        
        self.addOrderViewModel.name = name
        self.addOrderViewModel.email = email
        self.addOrderViewModel.selectedSize = selectedSize
        self.addOrderViewModel.selectedType = self.addOrderViewModel.types[selectedIndexPath.row]
        
        NetworkService().load(resource: Order.create(vm: addOrderViewModel)) { [unowned self] result in
            switch result {
            case .success( _):
                    print("Sent to server!")
                    DispatchQueue.main.async {
                        self.delegate?.viewControllerDidPressSave()
                        self.navigationController?.popViewController(animated: true)
                    }
            case .failure(let failure):
                print("Failed to add to server: \(failure.localizedDescription)")
            }
        }
    }
    
    
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        segmentControll.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    private func dissmissKeyboard() {
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func endEdit() {
    view.endEditing(true)
    }
}
