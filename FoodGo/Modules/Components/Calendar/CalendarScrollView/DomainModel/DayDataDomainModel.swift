//
//  DayDataDomainModel.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import Foundation
struct DayDateDomainModel: Identifiable, Hashable, Equatable {
    let id = UUID()
    let dayName: String
    let dayNumber: Int
    let currentDay: Bool
    let monthName: String
    
    
    // Custom Equatable conformance, ignoring `id`
    static func == (lhs: DayDateDomainModel, rhs: DayDateDomainModel) -> Bool {
        return lhs.dayName == rhs.dayName &&
        lhs.dayNumber == rhs.dayNumber &&
        lhs.currentDay == rhs.currentDay &&
        lhs.monthName == rhs.monthName &&
        lhs.id == rhs.id
        
    }

    // Custom Hashable conformance, ignoring `id`
    func hash(into hasher: inout Hasher) {
        hasher.combine(dayName)
        hasher.combine(dayNumber)
        hasher.combine(currentDay)
        hasher.combine(monthName)
        hasher.combine(id)
    }
}
