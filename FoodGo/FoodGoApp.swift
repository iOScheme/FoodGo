//
//  FoodGoApp.swift
//  FoodGo
//
//  Created by Alex.personal on 14/8/24.
//

import SwiftUI
import SwiftData

@main
struct FoodGoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            FoodGoTabBar()
        }.modelContainer(for: UserPreferences.self)
    }
}
