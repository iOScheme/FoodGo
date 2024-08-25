//
//  CalendarHeader.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarHeader: View {
    let monthName: String
    var body: some View {
        HStack {
            Spacer()
            FoodGoImageView(resoureName: "arrow.left", width: 24, height: 12)
            FoodGoTextView(monthName, 18)
            FoodGoImageView(resoureName: "arrow.right", width: 24, height: 12)
            Spacer()
        }
       
    }
}

#Preview {
    CalendarHeader(monthName: "June")
}
