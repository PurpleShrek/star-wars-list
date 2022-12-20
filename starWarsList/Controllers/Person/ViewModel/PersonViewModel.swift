//
//  PersonViewModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import Foundation
import Combine

final class PersonViewModel {
    
    private let networkService: NetworkInterface = NetworkService()
    private let storage = PersonStorageManager()
    
    private(set)var personsCounter = 0
    
    @Published var personData: [Person]?
    
    private let urls: [String]?
    
    init(urls: [String]?) {
        self.urls = urls
        createPersons()
    }
}

//MARK: - Create empty data with urls
extension PersonViewModel {
    private func createPersons() {
        var dataArray = [Person]()
        for i in 0..<(urls?.count ?? 0) {
            let person = Person(name: nil, birthYear: nil, gender: nil, homeworld: nil, url: urls?[i])
            print(person)
            dataArray.append(person)
        }
        personData = dataArray
    }
}
    
//MARK: - Logic with data
extension PersonViewModel {
    public func fetchPersons() {
        //Прходимся по массиву url'ов и определяем есть ли Person в Хранилище, если есть, то тянем оттуда. Если нету качаем.
        for i in 0..<(personData?.count ?? 0) {
            let url = personData?[i].url
            let personFromStorage = getPersonFromStorage(url: url)
            switch personFromStorage {
            case nil:
                downloadPerson(url: url, index: i)
            default:
                let kek = personFromStorage!
                personData?[i] = kek
                personsCounter += 1
            }
        }
    }
    
    private func getPersonFromStorage(url: String?) -> Person? {
        let products = storage.getProducts()
        
        if let i = products.firstIndex(where: { $0.url == url }) {
            return products[i]
        } else {
            return nil
        }
    }
    
    private func downloadPerson(url: String?, index: Int) {
        guard let url else { return }
        Task(priority: .medium) {
            let entity = try await networkService.fetchData(type: Person.self, urlString: url)
            personData?[index] = entity
            personsCounter += 1
            saveToStorage(personData)
        }
    }
    
    private func saveToStorage(_ persons: [Person]?) {
        //Сохраняем в базу только пачкой после загрузки всех Person's (из базы + сеть). Чтобы не увеличивать возможность краша из-за постоянных get,remove,update запросов в кор дату
        guard personsCounter == personData?.count else { return }
        storage.updatePersons(personData)
    }
}
