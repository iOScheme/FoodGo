//
//  UserPreferences.swift
//  FoodGo
//
//  Created by Alex.personal on 6/9/24.
//

import Foundation
import SwiftData

@Model
class UserPreferences {
    var name: String
    var weight: Int
    var height: Int
    var plan: UserPlan
    var id: UUID
    
    init(id: UUID, name: String, weight: Int, heightt: Int, plan: UserPlan) {
        self.id = id
        self.name = name
        self.weight = weight
        self.height = heightt
        self.plan = plan
    }
}

enum UserPlan: String, Codable {
    case looseWeight = "Loose Weight"
    case gainWeight = "Gain Weeight"
}
