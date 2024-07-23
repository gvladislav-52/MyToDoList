//
//  CreateTodoController.swift
//  ToDoListPractics
//
//  Created by gvladislav-52 on 23.07.2024.
//

import UIKit

class CreateTodoController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.text = "Create a new todo item"
        label.textAlignment = .center
        return label
    }()
    
    private let createButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create item", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(createItemPressed), for: .touchUpInside)
        return button
    }()
    
    private let itemTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 24)
        tf.backgroundColor = .white
        tf.textColor = .black
        return tf
    }()
    
    @objc func createItemPressed() {
        print(itemTextField.text)
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(createButton)
        createButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
        
        view.addSubview(itemTextField)
        itemTextField.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 128, paddingLeft: 16, paddingRight: 16, height: 40)
        itemTextField.delegate = self
    }
}


extension CreateTodoController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
