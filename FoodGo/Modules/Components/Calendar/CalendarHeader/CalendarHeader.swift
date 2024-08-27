//
//  CalendarHeader.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarHeader: View {
    let monthName: String
    let leftArrowAction: ImageTapAction?
    let rightArrowAction: ImageTapAction?
    
    init(monthName: String, leftArrowAction: ImageTapAction? = nil, rightArrowAction: ImageTapAction? = nil) {
        self.monthName = monthName
        self.leftArrowAction = leftArrowAction
        self.rightArrowAction = rightArrowAction
    }
    var body: some View {
        HStack {
            Spacer()
            FoodGoImageView(resoureName: "arrow.left", width: 24, height: 12, action: leftArrowAction)
            FoodGoTextView(monthName, 18)
            FoodGoImageView(resoureName: "arrow.right", width: 24, height: 12, action: rightArrowAction)
            Spacer()
        }
       
    }
}

#Preview {
    CalendarHeader(monthName: "June")
}
