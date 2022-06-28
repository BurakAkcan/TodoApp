//
//  TodoViewModel.swift
//  Todo App(Realm)
//
//  Created by Burak AKCAN on 28.06.2022.
//

import Foundation
import RealmSwift
 


class TodoViewModel{
    static var sharedInstance = TodoViewModel()
    var tasks:[Task] = []
    
    private  init() {}
    
    typealias CompletionHandler = ()->Void
    
    let realm = try! Realm()
    
    func addTask(add:Task,completion:CompletionHandler ){
        
      try! realm.write {
          realm.add(add)
        }
        
        let savedTask = realm.objects(Task.self)
        tasks.removeAll(keepingCapacity: false)
        tasks.append(contentsOf: savedTask)
        
        print("task saved")
       
        completion()
    }
    
    func deleteAll(){
        
        try! realm.write({
            realm.deleteAll()
        })
        
    }
    
    func loadTask(completion:CompletionHandler){
        
        
        let savedTask = realm.objects(Task.self)
        tasks.removeAll(keepingCapacity: false)
        tasks.append(contentsOf: savedTask)
        tasks.sort { first, last in
            first.name < last.name
        }
        print(tasks.count)
    }
    func editTask(task:Task,updateTask:Task,completion:CompletionHandler){
        try! realm.write({
            realm.delete(task)
           
        })
        
        try! realm.write({
            realm.add(updateTask)
        })
        
        completion()
    }
    
    func deleteTask(task:Task,taskIndex:Int,completion:CompletionHandler){
        try! realm.write {
            realm.delete(task)
            tasks.remove(at: taskIndex)
            completion()
        }
    }
    
   
}
