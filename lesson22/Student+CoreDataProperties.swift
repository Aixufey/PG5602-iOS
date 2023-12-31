//
//  Student+CoreDataProperties.swift
//  lesson22
//
//  Created by Jack Xia on 07/11/2023.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var school: School?

}

extension Student : Identifiable {

}
