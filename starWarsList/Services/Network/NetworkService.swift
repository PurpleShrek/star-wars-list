//
//  NetworkService.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import Foundation

struct NetworkService: NetworkInterface {
    func urlRequest(urlString: String?) -> URLRequest? {
        guard let urlString else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept"      : "application/json"
        ]
        return urlRequest
    }
    
    func fetchData<T>(type: T.Type, urlString: String?) async throws -> T where T : Decodable {
        guard let request = urlRequest(urlString: urlString) else {
            throw APIError.requestFailed
        }
        let manager = APIManager()
        return try await manager.someFetch(type: type, urlRequest: request)
    }
}
