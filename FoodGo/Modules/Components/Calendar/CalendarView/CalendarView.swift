//
//  CalendarView.swift
//  FoodGo
//
//  Created by Alex.personal on 21/8/24.
//

import SwiftUI

struct CalendarView: View {
    let dayName: String
    let dayNumber: String
    
    var body: some View {
        VStack {
            FoodGoTextView(dayName, 10)
            FoodGoTextView(dayNumber, 10)
                .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                .background(Color.white)
                .clipShape(.circle)
                
        }
    }
}

#Preview {
    CalendarView(dayName: "Mon", dayNumber: "1")
}
