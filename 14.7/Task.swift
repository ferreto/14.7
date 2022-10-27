//
//  Task.swift
//  14.7
//
//  Created by Admin on 23.10.2022.
//

import Foundation
import RealmSwift


class Task: Object {
    
   // @objc dynamic var id = Int()
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = String()
    
    //устанавливаем PK
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    //статический метод для быстрой инициализации
    static func getUserObject(/*id: Int,*/ name: String) -> Task {
        let task = Task()
      //  task.id = id
        task.name = name
        return task
    }
}
