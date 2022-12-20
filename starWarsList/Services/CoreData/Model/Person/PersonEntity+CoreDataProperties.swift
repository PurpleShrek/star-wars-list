//
//  PersonEntity+CoreDataProperties.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 20/12/2022.
//
//

import Foundation
import CoreData


extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthYear: String?
    @NSManaged public var gender: String?
    @NSManaged public var homeworld: String?
    @NSManaged public var url: String?

}

extension PersonEntity : Identifiable {

}
