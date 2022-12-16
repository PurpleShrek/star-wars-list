//
//  FilmsStorageManager.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 15/12/2022.
//

import Foundation
import CoreData

final class FilmsStorageManager: StorageManager {
    //MARK: - Read
    private func fetchData() -> [FilmsEntity] {
        let request: NSFetchRequest<FilmsEntity> = FilmsEntity.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [FilmsEntity]()
    }
    
    public func getProducts() -> Films {
        let filmsEntity = fetchData()
        let count = filmsEntity.count
        var films = [Film]()
        for i in 0..<count {
            let film = Film(title: filmsEntity[i].name,
                            episodeID: Int(filmsEntity[i].episodeID),
                            director: filmsEntity[i].director,
                            producer: filmsEntity[i].producer,
                            releaseDate: filmsEntity[i].releaseDate)
            films.append(film)
        }
        return Films(count: count,
                     results: films)
    }
    
    //MARK: - Update
    private var entityName: String {
        guard let films = FilmsEntity.fetchRequest().entityName else { return "" }
        return films
    }
    
    public func updateFilms(_ films: [Film]) {
        self.remove(entityName: entityName)
        for i in 0..<films.count {
            guard let filmsEntity = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                        into: backgroundContext) as? FilmsEntity else { return }
            filmsEntity.releaseDate = films[i].releaseDate
            filmsEntity.producer = films[i].producer
            filmsEntity.director = films[i].director
            filmsEntity.name = films[i].title
            filmsEntity.episodeID = Int16(films[i].episodeID ?? -1)
        }
        self.save()
    }
}

