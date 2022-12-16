//
//  MainViewModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 15/12/2022.
//

import Foundation
import Combine

final class MainViewModel {
    @Published var films: Films?

    private let filmsService = FilmsService(settings: NetworkSettings())

    public func loadNews() {
        print("func called")
        fetchFilms()
    }
    
//    func getSearchResult(_ str: String) {
//        
//        let arr = arrUserData.filter({($0.name?.lowercased().contains(str) ?? false)})
//        self.userData.send((str.trimmingCharacters(in: .whitespacesAndNewlines) != "") ? arr : arrUserData)
//    }
    
}

//MARK: - Fetch News
extension MainViewModel {
    private func fetchFilms() {
        Task(priority: .userInitiated) {
            let entity = try await filmsService.fetchData(type: Films.self)
            films = entity
            print(films)
        }
    }
}
