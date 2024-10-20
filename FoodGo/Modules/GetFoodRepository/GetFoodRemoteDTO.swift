//
//  GetFoodRemoteDTO.swift
//  FoodGo
//
//  Created by Alex.personal on 15/10/24.
//

import Foundation

struct GetFoodRemoteDTO: Decodable {
    let foods: Foods
}

struct Foods: Decodable {
    let food: [FoodItem]
    let maxResults: String
    let pageNumber: String
    let totalResults: String

    enum CodingKeys: String, CodingKey {
        case food
        case maxResults = "max_results"
        case pageNumber = "page_number"
        case totalResults = "total_results"
    }
}

struct FoodItem: Decodable {
    let brandName: String?
    let foodDescription: String
    let foodId: String
    let foodName: String
    let foodType: String
    let foodUrl: String

    enum CodingKeys: String, CodingKey {
        case brandName = "brand_name"
        case foodDescription = "food_description"
        case foodId = "food_id"
        case foodName = "food_name"
        case foodType = "food_type"
        case foodUrl = "food_url"
    }
}
