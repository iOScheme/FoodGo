//
//  GetFoodUseCase.swift
//  FoodGo
//
//  Created by Alex.personal on 15/10/24.
//

import Foundation

final class GetGoodUseCase {
    let remoteDataSource: GetFoodRemoteDataSourceProtocol
    
    init(remoteDataSource: GetFoodRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func execute(endpoint: GetFoodEndpoint)  async throws -> GetFoodRemoteDTO {
        return try await remoteDataSource.getFoods(endpoint: endpoint)
    }
}
