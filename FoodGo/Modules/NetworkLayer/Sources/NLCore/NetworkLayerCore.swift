//
//  File.swift
//  NetworkLayer
//
//  Created by Alex.personal on 2/10/24.
//

import Foundation

public protocol NetworkLayerCoreProtocol {
    func execute(request: URLRequest) async throws -> (Data, URLResponse)
}

public final class NetworkLayerCore: NetworkLayerCoreProtocol {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func execute(request: URLRequest) async throws -> (Data, URLResponse)  {
         return try await session.data(for: request)
    }
}
