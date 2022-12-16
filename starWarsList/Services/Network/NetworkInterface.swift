//
//  NetworkInterface.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import Foundation

protocol NetworkInterface {
    var settings: NetworkSettings { get }
    func urlRequest(method: NetworkMethod) -> URLRequest?
    func fetchData<T: Decodable>(type: T.Type) async throws -> T
}
