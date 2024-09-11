//
//  ProfileRead.swift
//  FoodGo
//
//  Created by Alex.personal on 9/9/24.
//

import SwiftUI

struct ProfileRead: View {
    private let model: ProfileEditViewModel = ProfileEditViewModel()
    private let userPreferences: UserPreferences?
    
    
    init() {
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
                    username: .constant(userPreferences?.name ?? "")
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
                        FoodGoTextView(
                            userPreferences?.weight.description ?? "kg",
                            20,
                            foregroundColor: .black
                        )
                    }
                    HStack {
                        FoodGoTextView(
                            "Height",
                            20,
                            foregroundColor: .black
                        )
                        Spacer()
                        FoodGoTextView(
                            userPreferences?.height.description ?? "Height",
                            20,
                            foregroundColor: .black
                        )
                    }
                    
                    HStack {
                        Spacer()
                        
                        Picker("Plan", selection: .constant("value")) {
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
        }
    }
}

#Preview {
    ProfileRead()
}
