//
//  Task.swift
//  Todo App(Realm)
//
//  Created by Burak AKCAN on 27.06.2022.
//

import Foundation
import RealmSwift



class Task: Object{
  @Persisted  var name:String=""
  @Persisted var time:Date=Date()
    
    
    
    convenience init(name: String,time:Date) {
        self.init()
        self.name = name
        self.time = time
    }
}
