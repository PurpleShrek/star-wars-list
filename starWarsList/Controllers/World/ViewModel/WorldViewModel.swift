//
//  WorldViewModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import Foundation
import Combine

final class WorldViewModel {
    
    private let networkService: NetworkInterface = NetworkService()
    private let storage = WorldStorageManager()

    @Published var world: World?
    
    private let url: String?
    
    init(url: String?) {
        self.url = url
        fetchWorld()
    }
}

//MARK: - Fetch World
extension WorldViewModel {
    private func fetchWorld() {
        let worldFromStorage = getWorldFromStorage(url: url)
        switch worldFromStorage {
        case nil:
            downloadWorld()
        default:
            world = worldFromStorage
        }
    }
    
    private func getWorldFromStorage(url: String?) -> World? {
        let products = storage.getProducts()

        if let i = products.firstIndex(where: { $0.url == url }) {
            return products[i]
        } else {
            return nil
        }
    }
    
    private func downloadWorld() {
        Task(priority: .medium) {
            guard let urlString = url else { return }
            let entity = try await networkService.fetchData(type: World.self,
                                                            urlString: urlString)
            world = entity
            saveToStorage(entity)
        }
    }

    private func saveToStorage(_ world: World) {
        storage.updateWorlds([world])
    }
}
