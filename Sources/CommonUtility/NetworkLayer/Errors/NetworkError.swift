//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 11/04/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int, Data?)
    case decoding(Error)
    case network(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "Invalid response"
            case .statusCode(let code, _):
                return "Request failed with status code: \(code)"
            case .decoding(let error):
                return "Decoding failed: \(error.localizedDescription)"
            case .network(let error):
                return "Network error: \(error.localizedDescription)"
        }
    }
}
