//
//  FilmsEntity+CoreDataProperties.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//
//

import Foundation
import CoreData


extension FilmsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmsEntity> {
        return NSFetchRequest<FilmsEntity>(entityName: "FilmsEntity")
    }

    @NSManaged public var director: String?
    @NSManaged public var name: String?
    @NSManaged public var producer: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var episodeID: Int16

}

extension FilmsEntity : Identifiable {

}
