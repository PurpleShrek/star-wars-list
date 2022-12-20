//
//  PersonModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import Foundation

// MARK: - Person
struct Person: Codable, Hashable {
    let name, birthYear, gender, homeworld: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case gender, homeworld
        case url
    }
}
