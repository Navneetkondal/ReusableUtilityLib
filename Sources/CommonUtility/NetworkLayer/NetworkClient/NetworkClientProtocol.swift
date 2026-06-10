//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 11/04/26.
//

import Foundation
protocol NetworkClientProtocol {
    func request<T: Decodable>(_ request: URLRequest) async throws -> T
}
