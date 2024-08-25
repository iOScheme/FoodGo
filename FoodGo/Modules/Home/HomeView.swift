//
//  ContentView.swift
//  FoodGo
//
//  Created by Alex.personal on 14/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Spacer(minLength: 24)
        VStack {
            HStack {
                Spacer(minLength: 16)
                UserCard()
            }
            Spacer(minLength: 24)
            VStack {
                CalendarScrollView().padding(EdgeInsets(top: 0, leading: 70, bottom: 0, trailing: 70))
            }
            Spacer()
        }
       
    }
}

#Preview {
    HomeView()
}

