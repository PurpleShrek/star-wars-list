//
//  APIError.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case responseFailed(description: String)
    case jsonConversionFailure(description: String)
}
