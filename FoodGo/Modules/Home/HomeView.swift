//
//  ContentView.swift
//  FoodGo
//
//  Created by Alex.personal on 14/8/24.
//

import SwiftUI

struct HomeView: View {
    private let viewModel = HomeViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.getDaysInMonth()) { dayData in
                    VStack {
                        if dayData.currentDay {
                            Text("\(dayData.dayNumber)").foregroundStyle(.red)
                            Text(dayData.dayName)
                        } else {
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
