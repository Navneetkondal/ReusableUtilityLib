//
//  URLBuilder.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 05/05/26.
//

import Foundation

protocol URLBuilder{
    func combineURLs(_ basePath: String, _ paths: String) -> String
    func combineURLs(_ basePath: String, _ paths: [String]) -> String
    func buildURL(withBaseURL baseURL: String, andPaths paths: [String], query params: [String: String]?) throws -> URL 
}

extension URLBuilder{
    func combineURLs(_ basePath: String, _ paths: String) -> String {
        return combineURLs(basePath, [paths])
    }
    
    func combineURLs(_ basePath: String, _ paths: [String]) -> String {
        let paths = [basePath] + paths
        return paths.map({ path in
            var path = path
            if path.first == "/"{
                path.removeFirst()
            }
            if path.last == "/"{
                path.removeLast()
            }
            return path
        }).joined(separator: "/")
    }
    
    func buildURL(withBaseURL baseURL: String, andPaths paths: [String], query params: [String: String]?) throws -> URL {
        let path = combineURLs(baseURL, paths)
        guard var comp = URLComponents(string: path) else{
            throw NetworkError.invalidURL
        }
        if let query = params {
            comp.queryItems = query.map {URLQueryItem(name: $0.key, value: $0.value)}
        }
        guard let url = comp.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
