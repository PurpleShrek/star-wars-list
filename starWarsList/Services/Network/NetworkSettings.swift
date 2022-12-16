//
//  NetworkSettings.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import Foundation

enum NetworkMethod: String {
    case get = "GET"
}

struct NetworkSettings {
    public var url: String {
        "https://swapi.dev/api/"
    }
    
    public var header: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept"      : "application/json"
        ]
    }
}

