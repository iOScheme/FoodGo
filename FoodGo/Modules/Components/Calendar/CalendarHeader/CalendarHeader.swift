//
//  CalendarHeader.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarHeader: View {
    let monthName: String
    let year: Int?
    let leftArrowAction: ImageTapAction?
    let rightArrowAction: ImageTapAction?
    
    init(monthName: String, year: Int? = nil, leftArrowAction: ImageTapAction? = nil, rightArrowAction: ImageTapAction? = nil) {
        self.monthName = monthName
        self.leftArrowAction = leftArrowAction
        self.rightArrowAction = rightArrowAction
        self.year = year
    }
    var body: some View {
        HStack(alignment: .center) {
            
            FoodGoImageView(resoureName: "arrow.left", width: 24, height: 12, action: leftArrowAction)
            if let year = year {
                VStack {
                    FoodGoTextView("\(year)", 10)
                    FoodGoTextView(monthName, 18)
                }
            } else {
                FoodGoTextView(monthName, 18)
            }
           
            FoodGoImageView(resoureName: "arrow.right", width: 24, height: 12, action: rightArrowAction)
        }
    }
}

#Preview {
    CalendarHeader(monthName: "June", year: 2024)
}
