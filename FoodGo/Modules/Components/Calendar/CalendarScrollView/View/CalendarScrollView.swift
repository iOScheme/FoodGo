//
//  CalendarScrollView.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarScrollView: View {
    var days: [DayDateDomainModel]
    
    init(days: [DayDateDomainModel], selectedDay: DayDateDomainModel? = nil) {
        self.days = days
        self.selectedDay = selectedDay
    }
    
    @State var selectedDay: DayDateDomainModel? = nil
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(days, id: \.self) { dayData in
                        if dayData.currentDay {
                            VStack {
                                CalendarView(
                                    dayName: dayData.dayName,
                                    dayNumber: "\(dayData.dayNumber)",
                                    isSelected: selectedDay == nil ? true : false
                                ).onAppear {
                                    proxy.scrollTo(dayData, anchor: .center)
                                }
                            }
                        } else {
                            CalendarView(
                                dayName: dayData.dayName,
                                dayNumber: "\(dayData.dayNumber)",
                                isSelected: dayData == selectedDay
                            ).onTapGesture {
                                withAnimation {
                                    selectedDay = dayData
                                    proxy.scrollTo(dayData, anchor: .center)
                                }
                            }.onAppear {
                                print(dayData.monthName)
                            }
                        }
                        Spacer(minLength: 24)
                    }
                }
            }
//            .onChange(of: days) {
//                proxy.scrollTo(days.first, anchor: .center)
//            }
        }
        Spacer()
    }
}

#Preview {
    HomeView()
}


