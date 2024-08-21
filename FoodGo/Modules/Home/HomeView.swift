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
            ScrollView {
                ForEach(viewModel.getDaysInMonth(), id: \.self) { dayData in
                    VStack {
                        if dayData.currentDay {
                            Text("\(dayData.dayNumber)").foregroundStyle(.red)
                            Text(dayData.dayName).onAppear {
                                proxy.scrollTo(dayData, anchor: .center)
                            }
                            
                            
                        } else {
                            Text(dayData.monthName)
                            Text("\(dayData.dayNumber)")
                            Text(dayData.dayName)
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
