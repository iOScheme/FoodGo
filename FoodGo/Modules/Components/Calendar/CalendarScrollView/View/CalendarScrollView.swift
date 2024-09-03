//
//  CalendarScrollView.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarScrollView: View {
    var days: [DayDateDomainModel] = []
    @State var selectedDay: DayDateDomainModel? = nil
    
    init(days: [DayDateDomainModel], selectedDay: DayDateDomainModel? = nil) {
        self.days = days
        self.selectedDay = selectedDay
    }
    
   
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(days, id: \.id) { dayData in
                        if dayData.currentDay {
                                CalendarView(
                                    dayName: dayData.dayName,
                                    dayNumber: "\(dayData.dayNumber)",
                                    isSelected: selectedDay == nil ? true : false
                                ).onAppear {
                                    proxy.scrollTo(dayData.id, anchor: .center)
                                }
                            
                        } else {
                            CalendarView(
                                dayName: dayData.dayName,
                                dayNumber: "\(dayData.dayNumber)",
                                isSelected: dayData == selectedDay
                            ).onTapGesture {
                                withAnimation {
                                    selectedDay = dayData
                                    proxy.scrollTo(dayData.id, anchor: .center)
                                }
                            }.onAppear {
                                print(dayData.monthName)
                            }
                        }
                        Spacer(minLength: 24)
                    }.onChange(of: days) { _, newValue in
                        withAnimation {
                            /// needs the new value because each cell has a new identity so its need this new identity to know
                            /// at what new cell it has to scroll
                            /// old identity its distroyed
                            if let firstDay = newValue.first {
                                proxy.scrollTo(firstDay.id, anchor: .center)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}


