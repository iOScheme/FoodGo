//
//  Date+Helpers.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import Foundation

extension DateFormatter {
    
    private struct Constants {
        static let shortDayFormat = "EEE"
        static let longDayFormat = "EEEE"
        static let shortMonthFormat = "MMM"
        static let longMonthFormat = "MMMM"
    }
    
    enum Component {
        case month
        case day
    }
    
    enum NameStyle {
        case short(Component)
        case full(Component)
        
        var style: String {
            switch self {
            case .short(let component):
                switch component {
                case .month:
                    return Constants.shortMonthFormat
                case .day:
                    return Constants.shortDayFormat
                }
            case .full(let component):
                switch component {
                case .month:
                    return Constants.longMonthFormat
                case .day:
                    return Constants.longDayFormat
                }
            }
        }
    }
    
    
    ///  `long`  gives the full day name, e.g., "Monday"
    ///  `short` gives the short day name, e.g., "Mon"
    func getDayName(from date: Date, nameStyle: NameStyle) -> String {
        
        self.dateFormat = nameStyle.style
        return self.string(from: date)
    }
    
    func getDayNumber(from date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    /// `long` "MMMM" gives full month name, e.g "January"
    ///  `short` "MMM" for short name "Jan"
    func getMonthName(from date: Date, nameStyle: NameStyle) -> String {
        
        self.dateFormat = nameStyle.style
        return self.string(from: date)
    }
}
