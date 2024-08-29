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
    var monthName: String = ""
    lazy var currentDay: Int = {
        calendar.component(.day, from: currentDate)
    }()
    lazy var currentMonth: Int = {
        calendar.component(.month, from: currentDate)
    }()
    private var previousMonth: Int = 0
    private var nextMonth: Int = 0
    private var nextDate: Date? = nil
    private var previousMonthDate: Date? = nil
    
    func getPreviousMonth() ->  [DayDateDomainModel] {
        let referenceDate = (nextDate ?? previousMonthDate)
        let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: referenceDate ?? currentDate)
        nextDate = previousMonthDate
      self.previousMonthDate = previousMonthDate
      return getDaysInMonth(date: previousMonthDate)
    }
    
    func getNextMonth() ->  [DayDateDomainModel] {
      previousMonth = nextMonth + 1
      let nextMonth = calendar.date(byAdding: .month, value: 1, to: nextDate ?? currentDate)
      self.nextDate = nextMonth
      return getDaysInMonth(date: nextMonth)
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
