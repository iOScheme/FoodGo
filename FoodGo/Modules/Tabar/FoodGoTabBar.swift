//
//  FoodGoTabBar.swift
//  FoodGo
//
//  Created by Alex.personal on 3/9/24.
//

import SwiftUI

struct FoodGoTabBar: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Text("Home")
            }
            
            FoodGoProfile(kg: "", height: "", pickerSelection: "", username: "").tabItem {
                Text("Profile")
            }
        }
    }
}

#Preview {
    FoodGoTabBar()
}
