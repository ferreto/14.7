//
//  tasksName+CoreDataProperties.swift
//  
//
//  Created by Admin on 25.10.2022.
//
//

import Foundation
import CoreData


extension tasksName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<tasksName> {
        return NSFetchRequest<tasksName>(entityName: "Tasks")
    }

    @NSManaged public var taskName: String?

}
