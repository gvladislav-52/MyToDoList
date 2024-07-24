//
//  PostService.swift
//  ToDoListPractics
//
//  Created by gvladislav-52 on 24.07.2024.
//

import UIKit
import Firebase

struct ToDoItem {
    var title: String
    var isComplete: Bool
    //var id: Int
    
    init(keyID: String, dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.isComplete = dictionary["isComplete"] as? Bool ?? false
    }
}

struct PostService {
    
    static let shared = PostService()
    
    let DB_REF = Database.database().reference()
    
    func fetchAllItems(completion: @escaping([ToDoItem]) -> Void)  {
        
    var allItems = [ToDoItem]()
    
        DB_REF.child("items").observe(.childAdded) { (snapshot) in
            fetchSingleItem(id: snapshot.key) { (item) in
                allItems.append(item)
                completion(allItems)
            }
        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(ToDoItem) -> Void) {
        DB_REF.child("items").child(id).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let todoItem = ToDoItem(keyID: id, dictionary: dictionary)
            completion(todoItem)
        }
    }
}
