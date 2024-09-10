//
//  FoodGoProfile.swift
//  FoodGo
//
//  Created by Alex.personal on 3/9/24.
//

import SwiftUI
import SwiftData

struct FoodGoProfile: View {
    @State private var kg: String
    @State private var height: String
    @State private var pickerSelection: String
    @State private var username: String
    @FocusState private var textFieldisFocused: Bool
    @Environment(\.modelContext) var modelContext
    @Query var preferences: [UserPreferences]
    
    init(kg: String, height: String, pickerSelection: String, username: String) {
        self.kg = kg
        self.height = height
        self.pickerSelection = pickerSelection
        self.username = username
    }
    
    var body: some View {
        ProfileEdit(
            kg: $kg,
            height: $height,
            pickerSelection: $pickerSelection,
            username: $username
        )
    }
}

#Preview {
    FoodGoProfile(kg: "", height: "", pickerSelection: "", username: "")
}
