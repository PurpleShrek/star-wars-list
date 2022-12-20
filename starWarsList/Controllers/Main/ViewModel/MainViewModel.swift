//
//  MainViewModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 15/12/2022.
//

import Foundation
import Combine

final class MainViewModel {
    
    private let networkService: NetworkInterface = NetworkService()
    private let storage = FilmsStorageManager()

    @Published var films: Films?
    @Published var loadState = true
}

//MARK: - Fetch News
extension MainViewModel {
    public func fetchFilms() {
        let products = storage.getProducts()
        let count = products.results?.count ?? 0
        if count == 0 {
            print("load started")
            downloadFilms()
        } else {
            print("core data started")
            self.films = sortingFilms(products)
        }
    }
    
    private func downloadFilms() {
        Task(priority: .userInitiated) {
            let urlString = "https://swapi.dev/api/films"
            do {
                let entity = try await networkService.fetchData(type: Films.self,
                                                                urlString: urlString)
                films = sortingFilms(entity)
                saveToStorage(films)
            } catch {
                loadState = false
            }
        }
    }
    
    private func saveToStorage(_ films: Films?) {
        storage.updateFilms(films?.results)
    }
    
    private func sortingFilms(_ films: Films) -> Films {
        let sortedFilms = films.results?.sorted { $0.episodeID < $1.episodeID }
        return Films(count: sortedFilms?.count, results: sortedFilms)
    }
}

//MARK: - TextField Film Finder
extension MainViewModel {
    
    func getSearchResult(_ str: String) {
        let filmsFromStorage = storage.getProducts()
        if str == "" {
            films = sortingFilms(filmsFromStorage)
        } else {
            let arrFilter = filmsFromStorage.results?.filter({($0.title?.lowercased().contains(str.lowercased()))!})
            let filerFilm = Films(count: arrFilter?.count, results: arrFilter)
            films = sortingFilms(filerFilm)
        }
    }
}
