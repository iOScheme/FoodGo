//
//  ContentView.swift
//  FoodGo
//
//  Created by Alex.personal on 14/8/24.
//

import SwiftUI

struct HomeView: View {
    private var viewModel = CalendarViewModel()
    @State var toggledMonth: [DayDateDomainModel] = []
    
    var body: some View {
        Spacer(minLength: 24)
        VStack {
            HStack {
                Spacer(minLength: 16)
                UserCard()
            }
            Spacer(minLength: 24)
            CalendarHeader(monthName: viewModel.monthName, leftArrowAction: {
                toggledMonth = viewModel.getPreviousMonth()
            }, rightArrowAction: {
                toggledMonth = viewModel.getNextMonth()
            })
            Spacer(minLength: 24)
            VStack {
                CalendarScrollView(days: toggledMonth).padding(EdgeInsets(top: 0, leading: 70, bottom: 0, trailing: 70))
            }
            Spacer()
        }.onAppear {
            toggledMonth = viewModel.getDaysInMonth()
        }
       
    }
}

#Preview {
    HomeView()
}

