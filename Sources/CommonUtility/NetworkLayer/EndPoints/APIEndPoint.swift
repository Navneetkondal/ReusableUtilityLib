//
//  APIEndPoint.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 05/05/26.
//

import Foundation

protocol APIEndPoint: URLBuilder{
    var baseURL: String? { get }
    var endPath: String? { get }
    var endPaths: [String]? { get }
    
    var fullURL: String? { get } // if already complete

    var method: HTTPRequestMethod { get}
    
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var body: Data? { get }
    
    var timeout: TimeInterval { get}
}

extension APIEndPoint{
  
    var baseURL: String? { nil }
    var endPath: String? { nil }
    var endPaths: [String]? { nil }

    var fullURL: String? {nil}
        
    var method: HTTPRequestMethod { .GET }
    var headers: [String: String]? { nil }
    var queryParams: [String: String]? { nil }
    
    var body: Data? { nil }
    var timeout: TimeInterval { 30 }
}
