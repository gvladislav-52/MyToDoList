//
//  CreateTodoController.swift
//  ToDoListPractics
//
//  Created by gvladislav-52 on 23.07.2024.
//

import UIKit

protocol CreateTodoControllerDelegate: AnyObject {
    func didCreateNewTodo()
}

class CreateTodoController: UIViewController {
    
    weak var delegate: CreateTodoControllerDelegate?
    
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
        let tf = TextField()
        tf.font = .systemFont(ofSize: 24)
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.layer.cornerRadius = 10
        tf.placeholder = "Enter a new task..."
        tf.tintColor = .systemGreen
        return tf
    }()
    
    @objc func createItemPressed() {
            guard let todoText = itemTextField.text, !todoText.isEmpty else { return }
            PostService.shared.uploadTodoItem(text: todoText) { [weak self] (error, ref) in
                if let error = error {
                    print("Failed to create item:", error.localizedDescription)
                    return
                }
                self?.itemTextField.text = ""
                self?.delegate?.didCreateNewTodo()  // Notify the delegate
                self?.dismiss(animated: true, completion: nil)
            }
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

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
