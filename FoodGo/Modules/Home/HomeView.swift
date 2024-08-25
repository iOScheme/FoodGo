//
//  ContentView.swift
//  FoodGo
//
//  Created by Alex.personal on 14/8/24.
//

import SwiftUI

struct HomeView: View {
    private let viewModel = HomeViewModel()
    @State var selectedDay: DayData? = nil
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.getDaysInMonth(), id: \.self) { dayData in
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
                            }
                        }
                        Spacer(minLength: 24)
                    }
                }
            }
        }
        Spacer()
    }
}

#Preview {
    HomeView()
}

