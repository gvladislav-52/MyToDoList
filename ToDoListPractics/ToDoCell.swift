//
//  ToDoCell.swift
//  ToDoListPractics
//
//  Created by gvladislav-52 on 23.07.2024.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    var todoItem: ToDoItem? {
            didSet {
                titleLabel.text = todoItem?.title
    
                if let isComplete = todoItem?.isComplete, isComplete {
                    statusLabel.text = "Status: Complete"
                    statusLabel.textColor = UIColor(red: 96/255, green: 108/255, blue: 56/255, alpha: 1.0)
                } else {
                    statusLabel.text = "Status: Incomplete"
                    statusLabel.textColor = UIColor(red: 208/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }
            }
        }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.text = "Title label"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Status: Incomplete"
        return label
    }()
    
        private let trashImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "trash")
            imageView.tintColor = .red
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true // Enable interaction
            return imageView
        }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 252/255, green: 163/255, blue: 17/255, alpha: 1.0)
        contentView.clipsToBounds = false
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(trashImageView)
        
        // Layout constraints
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        statusLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
                // Set constraints for trashImageView
                trashImageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    trashImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    trashImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
                    trashImageView.widthAnchor.constraint(equalToConstant: 24),
                    trashImageView.heightAnchor.constraint(equalToConstant: 24)
                ])
        
                // Add tap gesture recognizer to trashImageView
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTrash))
                trashImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapTrash() {
        // Implement the deletion action or delegate callback here
        print("Trash icon tapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
