//
//  WorldStorageManager.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 20/12/2022.
//

import Foundation
import CoreData

final class WorldStorageManager: StorageManager {
    //MARK: - Read
    private func fetchData() -> [WorldEntity] {
        let request: NSFetchRequest<WorldEntity> = WorldEntity.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [WorldEntity]()
    }
    
    public func getProducts() -> [World] {
        let worldEntity = fetchData()
        let count = worldEntity.count
        var worlds = [World]()
        for i in 0..<count {
            let person = World(name: worldEntity[i].name,
                               diameter: worldEntity[i].diameter,
                               climate: worldEntity[i].climate,
                               gravity: worldEntity[i].gravity,
                               terrain: worldEntity[i].terrain,
                               population: worldEntity[i].population,
                               url: worldEntity[i].url)
            worlds.append(person)
        }
        return worlds
    }
    
    //MARK: - Update
    private var entityName: String {
        guard let persons = WorldEntity.fetchRequest().entityName else { return "" }
        return persons
    }
    
    public func updateWorlds(_ downloadedWorlds: [World]?) {
        guard let downloadedWorlds else { return }
        
        let productsAlreadySaved = getProducts()
        
        let uniqueArray = Array(Set(downloadedWorlds + productsAlreadySaved))
        
        self.remove(entityName: entityName)
        
        for i in 0..<uniqueArray.count {
            guard let worldEntity = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                         into: backgroundContext) as? WorldEntity else { return }
            worldEntity.name = uniqueArray[i].name
            worldEntity.diameter = uniqueArray[i].diameter
            worldEntity.climate = uniqueArray[i].climate
            worldEntity.gravity = uniqueArray[i].gravity
            worldEntity.terrain = uniqueArray[i].terrain
            worldEntity.population = uniqueArray[i].population
            worldEntity.url = uniqueArray[i].url
        }
        self.save()
    }
}
