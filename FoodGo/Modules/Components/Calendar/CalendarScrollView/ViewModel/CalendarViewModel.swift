//
//  HomeViewModel.swift
//  FoodGo
//
//  Created by Alex.personal on 15/8/24.
//

import Foundation
import SwiftUI

class CalendarViewModel {
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
    
    init() {
        updateYear(for: currentDate)
    }
    
    var monthName: String = ""
    lazy var currentDay: Int = {
        calendar.component(.day, from: currentDate)
    }()
    lazy var currentMonth: Int = {
        calendar.component(.month, from: currentDate)
    }()
    
    private var nextDate: Date? = nil
    private var previousMonthDate: Date? = nil
    var currentYear = 0
    
    
    
    func goToPreviousMonth() -> [DayDateDomainModel] {
        let referenceDate = (nextDate ?? previousMonthDate)
        var dateComponents = DateComponents()
        dateComponents.month = -1 // Move back one month

        // Use the current calendar to calculate the previous date
        let calendar = Calendar.current
        let previousDate = calendar.date(byAdding: dateComponents, to: referenceDate ?? currentDate)
        updateYear(for: previousDate)
        nextDate = previousMonthDate
        self.previousMonthDate = previousDate
        return getDaysInMonth(date: previousMonthDate)
    }
    
    func getNextMonth() ->  [DayDateDomainModel] {
        let referenceDate = (nextDate ?? previousMonthDate)
        var dateComponents = DateComponents()
        dateComponents.month = +1 // Move forward one month

        // Use the current calendar to calculate the next date
        let calendar = Calendar.current
        let nextMonth = calendar.date(byAdding: dateComponents, to: referenceDate ?? currentDate)
        updateYear(for: nextMonth)
        self.nextDate = nextMonth
        return getDaysInMonth(date: nextMonth)
    }
    
    private func updateYear(for date: Date?) {
        guard let date = date else { return }
        currentYear = calendar.component(.year, from: date)
    }
   
    func getDaysInMonth(date: Date? = nil) -> [DayDateDomainModel] {
        var components = DateComponents()
        components.year = calendar.component(.year, from: date ?? Date())
        components.month = getMonthNumber(from: date ?? currentDate)
        components.day = 1
        
        let dateComponents = DateComponents(year: components.year, month: components.month, day: components.day)
        
        // Get the current day of the month
        guard let startDate = calendar.date(from: dateComponents) else { return [] }
        
        // Determine the range of days in the month
         guard let range = calendar.range(of: .day, in: .month, for: startDate) else { return [] }
        
        
        
        // Generate all dates within the range
        return range.compactMap { day -> Date? in
            let components = DateComponents(year: components.year, month: components.month, day: day)
            return calendar.date(from: components)
        }.map({
            monthName = dateFormatter.getMonthName(from: $0, nameStyle: .full(.month))
            return DayDateDomainModel(
                dayName: dateFormatter.getDayName(from: $0, nameStyle: .short(.day)),
                dayNumber: getDayNumber(from: $0),
                currentDay: isCurrentDay(comparedDate: $0),
                monthName: monthName
            )
        })
    }
    
    private func isCurrentDay(comparedDate: Date) -> Bool {
        return calendar.component(.day, from: comparedDate) == currentDay && calendar.component(.month, from: comparedDate) == currentMonth
    }
    
    func getDayNumber(from date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    func getMonthNumber(from date: Date) -> Int {
        return calendar.component(.month, from: date)
    }
}
