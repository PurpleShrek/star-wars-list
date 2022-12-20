//
//  WorldEntity+CoreDataProperties.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 20/12/2022.
//
//

import Foundation
import CoreData


extension WorldEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorldEntity> {
        return NSFetchRequest<WorldEntity>(entityName: "WorldEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var diameter: String?
    @NSManaged public var climate: String?
    @NSManaged public var gravity: String?
    @NSManaged public var terrain: String?
    @NSManaged public var population: String?
    @NSManaged public var url: String?

}

extension WorldEntity : Identifiable {

}
