//
//  File.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 11/04/26.
//

import Foundation

public final class NetworkManager {
    
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol = NetworkClient()) {
        self.client = client
    }
    
    func request<T: Decodable>(endpoint: APIEndPoint) async throws -> T {
        let request = try RequestBuilder.build(from: endpoint)
        return try await client.request(request)
    }
}
