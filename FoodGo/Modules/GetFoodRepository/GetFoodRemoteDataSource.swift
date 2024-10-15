//
//  GetFoodRemoteDataSource.swift
//  FoodGo
//
//  Created by Alex.personal on 14/10/24.
//

import Foundation
import NetworkLayer

public final class GetFoodRemoteDataSource {
    private let remoteProvider: RequestProviderProtocol
    
    init(remoteProvider: RequestProviderProtocol) {
        self.remoteProvider = remoteProvider
    }
    
    public func getFoods<T: Decodable>(endpoint: GetFoodEndpoint) async throws -> T {
       try await remoteProvider.execute(endpoint: endpoint)
    }
}


public struct GetFoodEndpoint: NetworkLayerEndpoint {
    public var apiVersion: String? {
        "v1"
    }
    
    public var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "search_expression", value: searchExpression)]
    }
    
    public var path: String {
        "/food/search"
    }
    
    public var method: NetworkLayer.URLRequestMethod {
        .get
    }
    
    private let searchExpression: String
    
    init(searchExpression: String) {
        self.searchExpression = searchExpression
    }
}
