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
        fetchItems()
    
        title = "ToDoList"
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]

    }
    
    private func fetchItems() {
        PostService.shared.fetchAllItems { (allitems) in
            self.todoItems = allitems
        }
    }
    
    lazy var createNewButton: UIButton = {
        
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 252/255, green: 163/255, blue: 17/255, alpha: 1.0)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.zPosition
        
        button.addTarget(self, action: #selector(createNewTodo), for: .touchUpInside)
        
        return button
    }()
    
    func configureTableView() {
        tableView.backgroundColor = UIColor(red: 20/255, green: 33/255, blue: 61/255, alpha: 1.0)
        tableView.register(ToDoCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        tableView.rowHeight = 75
        tableView.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.tableFooterView = UIView()
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemGreen
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.addSubview(createNewButton)
        createNewButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 16, width: 56, height: 56)
        createNewButton.layer.cornerRadius = 56/2
        createNewButton.alpha = 1
    }
    
    @objc func createNewTodo() {
        let vc = CreateTodoController()
        present(vc,animated: true, completion: nil)
    }
    
    @objc func handleRefresh() {
        self.tableView.refreshControl?.beginRefreshing()
        
        if let isRefreshining = self.tableView.refreshControl?.isRefreshing, isRefreshining {
            DispatchQueue.main.async { [weak self] in
                self?.fetchItems()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
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
        let todoItem = todoItems[indexPath.row]
        
        PostService.shared.updateItemStatus(todoItem: todoItem.id, isComplete: true) { (error, reference) in
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.fetchItems()
        }
        //tableView.deselectRow(at: indexPath, animated: true)
    }
}

