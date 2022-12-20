//
//  APIManager.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import Foundation

final class APIManager {
    
    func someFetch<T: Decodable>(type: T.Type,
                                 urlRequest: URLRequest) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseFailed(description: "Status code - \(httpResponse.statusCode)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}
