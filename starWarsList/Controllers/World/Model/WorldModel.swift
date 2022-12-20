//
//  WorldModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import Foundation

struct World: Codable, Hashable {
    let name, diameter: String?
    let climate, gravity, terrain: String?
    let population, url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case diameter, climate, gravity, terrain
        case population, url
    }
}
