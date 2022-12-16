//
//  StorageManager.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 15/12/2022.
//

import Foundation
import CoreData

class StorageManager {
    //MARK: - PersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Storage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: - Context
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    //MARK: - Create / Update
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
    //MARK: - Delete
    func remove(entityName: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try backgroundContext.execute(deleteRequest)
            try backgroundContext.save()
        } catch {
            print ("CORE DATA - Erorr delete entity: \(entityName)")
        }
    }
}
