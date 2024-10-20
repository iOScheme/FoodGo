//
//  GetFoodRemoteDataSource.swift
//  FoodGo
//
//  Created by Alex.personal on 14/10/24.
//

import Foundation
import NetworkLayer

protocol GetFoodRemoteDataSourceProtocol {
     func getFoods(endpoint: GetFoodEndpoint) async throws -> GetFoodRemoteDTO
}

final class GetFoodRemoteDataSource: GetFoodRemoteDataSourceProtocol {
    private let remoteProvider: RequestProviderProtocol
    
    init(remoteProvider: RequestProviderProtocol) {
        self.remoteProvider = remoteProvider
    }
    
    public func getFoods(endpoint: GetFoodEndpoint) async throws -> GetFoodRemoteDTO {
        try await remoteProvider.execute(endpoint: endpoint, dto: GetFoodRemoteDTO.self)
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

