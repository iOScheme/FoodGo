//
//  ProfileEdit.swift
//  FoodGo
//
//  Created by Alex.personal on 9/9/24.
//

import SwiftUI
import SwiftData

struct ProfileEdit: View {
    @Binding private var kg: String
    @Binding private var height: String
    @Binding private var pickerSelection: String
    @Binding private var username: String
    @FocusState private var textFieldisFocused: Bool
    private let model: ProfileEditViewModel = ProfileEditViewModel()
    private let userPreferences: UserPreferences?
    
    
    init(kg: Binding<String>, height: Binding<String>, pickerSelection: Binding<String>, username: Binding<String>) {
        self._kg = kg
        self._height = height
        self._pickerSelection = pickerSelection
        self._username = username
        self.userPreferences = model.retrieve(type: UserPreferences.self)
    }
    
    var body: some View {
        Form {
            VStack {
                UserCardProfile(
                    placeHolder: userPreferences?.name ?? "Username",
                    circleWidth: 150,
                    circleHeight: 144,
                    mainText: userPreferences?.name ?? "Username",
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
                            placeHolder: userPreferences?.weight.description ?? "kg",
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
                            placeHolder: userPreferences?.height.description ?? "Height",
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
        }.onSubmit {
            if let userPrefernces = userPreferences {
                userPrefernces.height = Int(height) ?? 0
                userPrefernces.weight = Int(kg) ?? 0
                userPrefernces.plan = .gainWeight
                userPrefernces.name = username
            } else {
                model.save(model: UserPreferences(
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
    //    ProfileEdit(kg: "kg", height: "height", pickerSelection: "", username: "username")
}
