//
//  CalendarScrollView.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarScrollView: View {
    @State private var selectedDay: DayDateDomainModel? = nil
    @StateObject private var viewModel: CalendarViewModel
    
    init(viewModel: CalendarViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
   
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.currentMonthDays, id: \.id) { dayData in
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
//                                print(dayData.monthName)
                            }
                        }
                        Spacer(minLength: 24)
                    }.onChange(of: viewModel.currentMonthDays) { _, newValue in
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


