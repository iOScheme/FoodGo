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
        VStack {
            UserCardHome(
                circleWidth: 52,
                circleHeight: 59,
                mainText: "Welcome",
                secondaryText: "User",
                mainTextSize: 20,
                secondaryTextSize: 16
            ).padding(
                EdgeInsets(
                    top: 16,
                    leading: 24,
                    bottom: 16,
                    trailing: 16
                )
            )
            CalendarHeader(
                monthName: viewModel.monthName,
                year: viewModel.currentYear,
                leftArrowAction: {
                    toggledMonth = viewModel.goToPreviousMonth()
                },
                rightArrowAction: {
                toggledMonth = viewModel.getNextMonth()
            }).padding()
            CalendarScrollView(days: toggledMonth)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 70,
                        bottom: 0,
                        trailing: 70
                    )
                )
           
            HStack {
                FoodGoTextView("Statistics", 25)
                Spacer()
            }.padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 16))
            Spacer()
           
        }.onAppear {
            toggledMonth = viewModel.getDaysInMonth()
        }
    }
}

#Preview {
    HomeView()
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
