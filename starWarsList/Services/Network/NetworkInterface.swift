//
//  NetworkInterface.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import Foundation

protocol NetworkInterface {
    func urlRequest(urlString: String?) -> URLRequest?
    func fetchData<T: Decodable>(type: T.Type, urlString: String?) async throws -> T
}
