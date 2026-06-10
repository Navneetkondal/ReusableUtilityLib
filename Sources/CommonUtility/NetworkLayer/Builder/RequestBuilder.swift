//
//  RequestBuilder.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 11/04/26.
//

import Foundation

struct RequestBuilder: URLBuilder {
    
    static func build(from endpoint: APIEndPoint) throws -> URLRequest {
        if let full = endpoint.fullURL, let u = URL(string: full) {
            return try buildRequest(for: u, from: endpoint)
        } else {
            guard let base = endpoint.baseURL else {
                throw NetworkError.invalidURL
            }
            let builder = RequestBuilder()
            if let path = endpoint.endPath {
                let url = try builder.buildURL(withBaseURL: base, andPaths: [path], query: endpoint.queryParams)
                return try buildRequest(for: url, from: endpoint)

            } else if let paths = endpoint.endPaths{
                let url = try builder.buildURL(withBaseURL: base, andPaths: paths, query: endpoint.queryParams)
                return try buildRequest(for: url, from: endpoint)
            }
        }
        throw NetworkError.invalidURL
    }
    
    static func buildRequest(for url: URL?, from endpoint: APIEndPoint) throws -> URLRequest {
        guard let url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = endpoint.timeout
        request.httpBody = endpoint.body
        endpoint.headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
}
