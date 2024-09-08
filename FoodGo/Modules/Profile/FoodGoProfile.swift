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
        Form {
            VStack {
                UserCardProfile(
                    placeHolder: preferences.first?.name ?? "Username",
                    circleWidth: 150,
                    circleHeight: 144,
                    mainText: preferences.first?.name ?? "Username",
                    mainTextSize: 40,
                    username: $username
                ).padding(
                    EdgeInsets(
                        top: 48,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
                VStack {
                    HStack {
                        FoodGoTextView("Weight", 20, foregroundColor: .black)
                        Spacer()
                        FoodGoTextField(
                            placeHolder: preferences.first?.weight.description ?? "kg",
                            binding: $kg,
                            hideKeyboard: _textFieldisFocused
                        )
                    }
                    HStack {
                        FoodGoTextView(
                            "Height",
                            20,
                            foregroundColor: .black
                        )
                        Spacer()
                        FoodGoTextField(
                            placeHolder: preferences.first?.heightt.description ?? "Height",
                            binding: $height,
                            hideKeyboard: _textFieldisFocused
                        )
                    }
                    
                    HStack {
                        Spacer()
                        
                        Picker("Plan", selection: $pickerSelection) {
                            Text("Loose weight")
                            Text("Gain weight")
                        }.pickerStyle(.menu)
                    }
                }.padding(
                    EdgeInsets(
                        top: 16,
                        leading: 32,
                        bottom: 16,
                        trailing: 32
                    )
                )
                Spacer()
            }
        }.onTapGesture {
            hideKeyboard()
        }.onSubmit {
            
        let userPreferences = try? modelContext.fetch(FetchDescriptor<UserPreferences>())
            
            if let userPrefernces = userPreferences {
                userPrefernces.first?.heightt = Int(height) ?? 0
                userPrefernces.first?.weight = Int(kg) ?? 0
                userPrefernces.first?.plan = .gainWeight
                userPrefernces.first?.name = username
            } else {
                modelContext.insert(
                    UserPreferences(
                        id: UUID(),
                        name: username,
                        weight: Int(kg) ?? 0,
                        heightt: Int(height) ?? 0,
                        plan: .gainWeight
                    )
                )
            }
        }
    }
}

#Preview {
    FoodGoProfile(kg: "", height: "", pickerSelection: "", username: "")
}
