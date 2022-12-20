//
//  FilmsModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import Foundation

// MARK: - Films
struct Films: Codable {
    let count: Int?
    let results: [Film]?
}

// MARK: - Result
struct Film: Codable, Hashable {
    let title: String?
    let episodeID: Int
    let director, producer, releaseDate: String?
    let characters: [String]?

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case director, producer
        case releaseDate = "release_date"
        case characters
    }
}
