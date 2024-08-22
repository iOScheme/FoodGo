//
//  ContentView.swift
//  FoodGo
//
//  Created by Alex.personal on 14/8/24.
//

import SwiftUI

struct HomeView: View {
    private let viewModel = HomeViewModel()
    let days = HomeViewModel().getDaysInMonth()
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.getDaysInMonth(), id: \.self) { dayData in
                        
                        if dayData.currentDay {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25).frame(width: 30, height: 70).foregroundStyle(.red)
                                VStack {
                                    CalendarView(dayName: dayData.dayName, dayNumber: "\(dayData.dayNumber)")
                                        .onAppear {
                                            proxy.scrollTo(dayData, anchor: .center)
                                        }
                                }
                                
                            }
                            
                        } else {
                            CalendarView(dayName: dayData.dayName, dayNumber: "\(dayData.dayNumber)")
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
