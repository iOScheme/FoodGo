//
//  HomeViewModel.swift
//  FoodGo
//
//  Created by Alex.personal on 15/8/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    private let calendar = Calendar.current
    private let currentDate = Date()
    private lazy var dateFormatter: DateFormatter  = {
        let dateFormatter = DateFormatter()
        
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        let dateComponents = DateComponents(year: year, month: month, day: day)
        
        // Get the current day of the month
         let startDate = calendar.date(from: dateComponents)
        
        dateFormatter.defaultDate = startDate
        
        return dateFormatter
    }()
   
    func getDaysInMonth() -> [DayData] {
        

        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        let dateComponents = DateComponents(year: year, month: month, day: day)
        
        // Get the current day of the month
        guard let startDate = calendar.date(from: dateComponents) else { return [] }
        
        // Determine the range of days in the month
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else { return [] }
        
        // Get the current day
        let currentDay = calendar.component(.day, from: startDate)
        
        // Calculate the remaining days
        let remainingDays = range.count - currentDay
        
        
        // Generate all dates within the range
        return range.suffix(from: remainingDays).compactMap { day -> Date? in
            let components = DateComponents(year: year, month: month, day: day)
            return calendar.date(from: components)
        }.map({
            DayData(
                dayName: getDayName(from: $0),
                dayNumber: getDayNumber(from: $0),
                currentDay: getDayNumber(from: $0) == currentDay
            )
        })
    }
    
    func getDayName(from date: Date) -> String {
        
        dateFormatter.dateFormat = "EEEE" // "EEEE" gives the full day name, e.g., "Monday"
        return dateFormatter.string(from: date)
    }
    
    func getDayNumber(from date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
}

struct DayData: Identifiable {
    let id = UUID()
    let dayName: String
    let dayNumber: Int
    let currentDay: Bool
}

