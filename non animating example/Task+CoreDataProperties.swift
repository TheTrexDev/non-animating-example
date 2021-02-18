//
//  Task+CoreDataProperties.swift
//  non animating example
//
//  Created by James Warren on 19/2/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdOn: Date?
    @NSManaged public var name: String?
    @NSManaged public var isComplete: Bool

}

extension Task : Identifiable {

}
