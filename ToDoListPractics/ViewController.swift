//
//  ViewController.swift
//  ToDoListPractics
//
//  Created by gvladislav-52 on 23.07.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var todoItems = [ToDoItem]() {
        didSet {
            print("todo items was set")
            tableView.reloadData()
        }
    }
    
    let reuseIdentifer = "TodoCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        PostService.shared.fetchAllItems { (allitems) in
            self.todoItems = allitems
        }
        
        title = "ToDoList"
    }
    
    lazy var createNewButton: UIButton = {
        
        let button = UIButton()
        button.tintColor = .red
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.zPosition
        
        button.addTarget(self, action: #selector(createNewTodo), for: .touchUpInside)
        
        return button
    }()
    
    func configureTableView() {
        tableView.backgroundColor = .lightGray
        tableView.register(ToDoCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        tableView.rowHeight = 75
        tableView.separatorColor = .systemRed
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.tableFooterView = UIView()

        
        tableView.addSubview(createNewButton)
        createNewButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 16, width: 56, height: 56)
        createNewButton.layer.cornerRadius = 56/2
        createNewButton.alpha = 1
    }
    
    @objc func createNewTodo() {
        let vc = CreateTodoController()
        present(vc,animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate/UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as? ToDoCell else {return UITableViewCell()}
        
        cell.todoItem = todoItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

