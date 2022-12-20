//
//  PersonStorageManager.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 20/12/2022.
//

import Foundation
import CoreData

final class PersonStorageManager: StorageManager {
    //MARK: - Read
    private func fetchData() -> [PersonEntity] {
        let request: NSFetchRequest<PersonEntity> = PersonEntity.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [PersonEntity]()
    }
    
    public func getProducts() -> [Person] {
        let personsEntity = fetchData()
        let count = personsEntity.count
        var persons = [Person]()
        for i in 0..<count {
            let person = Person(name: personsEntity[i].name,
                                birthYear: personsEntity[i].birthYear,
                                gender: personsEntity[i].gender,
                                homeworld: personsEntity[i].homeworld,
                                url: personsEntity[i].url)
            persons.append(person)
        }
        return persons
    }
    
    //MARK: - Update
    private var entityName: String {
        guard let persons = PersonEntity.fetchRequest().entityName else { return "" }
        return persons
    }
    
    public func updatePersons(_ downloadedPersons: [Person]?) {
        guard let downloadedPersons else { return }
        
        let productsAlreadySaved = getProducts()
                
        let uniqueArray = Array(Set(downloadedPersons + productsAlreadySaved))
        
        self.remove(entityName: entityName)
        
        for i in 0..<uniqueArray.count {
            guard let personEntity = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                         into: backgroundContext) as? PersonEntity else { return }
            personEntity.name = uniqueArray[i].name
            personEntity.birthYear = uniqueArray[i].birthYear
            personEntity.gender = uniqueArray[i].gender
            personEntity.homeworld = uniqueArray[i].homeworld
            personEntity.url = uniqueArray[i].url
        }
        self.save()
    }
}

