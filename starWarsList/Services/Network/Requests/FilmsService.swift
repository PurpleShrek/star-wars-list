//
//  FilmsService.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 15/12/2022.
//

import Foundation

struct FilmsService: NetworkInterface {
    var settings: NetworkSettings
    
    init(settings: NetworkSettings) {
        self.settings = settings
    }
    
    func urlRequest(method: NetworkMethod) -> URLRequest? {
        let urlString = "\(settings.url)/films"
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = settings.header
        return urlRequest
    }
    
    func fetchData<T>(type: T.Type) async throws -> T where T : Decodable {
        guard let request = urlRequest(method: .get) else {
            throw APIError.requestFailed
        }
        let manager = APIManager()
        return try await manager.someFetch(type: type, urlRequest: request)
    }
}
