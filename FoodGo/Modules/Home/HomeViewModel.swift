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
    
    private lazy var days: [DayData] = {
       return getDaysInMonth()
    }()
    
    lazy var currentDay: Int = {
        calendar.component(.day, from: currentDate)
    }()
    
    lazy var currentMonth: Int = {
        calendar.component(.month, from: currentDate)
    }()
    
   
     func getDaysInMonth() -> [DayData] {
        var components = DateComponents()
        components.year = calendar.component(.year, from: Date())
        components.month = 1
        components.day = 1
        
        let dateComponents = DateComponents(year: components.year, month: components.month, day: components.day)
        
        // Get the current day of the month
        guard let startDate = calendar.date(from: dateComponents) else { return [] }
        
        // Determine the range of days in the month
        guard let range = calendar.range(of: .day, in: .year, for: startDate) else { return [] }
        
        // Get the current day
        
        
        // Generate all dates within the range
        return range.compactMap { day -> Date? in
            let components = DateComponents(year: components.year, month: components.month, day: day)
            return calendar.date(from: components)
        }.map({
            DayData(
                dayName: getDayName(from: $0),
                dayNumber: getDayNumber(from: $0),
                currentDay: isCurrentDay(comparedDate: $0),
                monthName: getMonthName(from: $0)
            )
        })
    }
    
    private func isCurrentDay(comparedDate: Date) -> Bool {
        return calendar.component(.day, from: comparedDate) == currentDay && calendar.component(.month, from: comparedDate) == currentMonth
    }
    
    func getDayName(from date: Date) -> String {
        
        dateFormatter.dateFormat = "EEE" // "EEEE" gives the full day name, e.g., "Monday"
        return dateFormatter.string(from: date)
    }
    
    func getDayNumber(from date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    func getMonthName(from date: Date) -> String {
        
        dateFormatter.dateFormat = "MMMM" // "MMMM" gives full month name; use "MMM" for short name
        return dateFormatter.string(from: date)
    }
}

struct DayData: Identifiable, Hashable {
    let id = UUID()
    let dayName: String
    let dayNumber: Int
    let currentDay: Bool
    let monthName: String
}

