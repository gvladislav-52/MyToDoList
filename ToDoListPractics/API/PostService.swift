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
    var id: String
    
    init(keyID: String, dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.isComplete = dictionary["isComplete"] as? Bool ?? false
        self.id = dictionary["id"] as? String ?? ""
    }
}

struct PostService {
    
    static let shared = PostService()
    
    let DB_REF = Database.database().reference()
    
    func fetchAllItems(completion: @escaping([ToDoItem]) -> Void)  {
        
    var allItems = [ToDoItem]()
    
        DB_REF.child("items").queryOrdered(byChild: "isComplete").observe(.childAdded) { (snapshot) in
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
    
    func uploadTodoItem(text: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let values = ["title": text, "isComplete": false] as [String: Any]
        let id = DB_REF.child("items").childByAutoId()
        id.updateChildValues(values, withCompletionBlock: completion)
        id.updateChildValues(values) { (error, reference) in
            let value = ["id": id.key!]
            DB_REF.child("items").child(id.key!).updateChildValues(value, withCompletionBlock: completion)
        }
    }
    
    func updateItemStatus(todoItem: String, isComplete: Bool, completetion: @escaping(Error?, DatabaseReference)->Void) {
        let value = ["isComplete": isComplete]
        
        DB_REF.child("items").child(todoItem).updateChildValues(value, withCompletionBlock: completetion)
    }
    
    func deleteAllItems(completion: @escaping(Error?, DatabaseReference) -> Void) {
            DB_REF.child("items").removeValue(completionBlock: completion)
        }
}
