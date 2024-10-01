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
                    username: .constant(userPreferences?.name ?? ""),
                    readOnly: true
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
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
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
                        FoodGoTextView(
                            "Plan",
                            20,
                            foregroundColor: .black
                        )
                        Spacer()
                        FoodGoTextView(
                            userPreferences?.plan.rawValue ?? "Select a plan",
                            20,
                            foregroundColor: .black
                        )
                    }.padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                }
                Spacer()
            }
        }.background(.foodGoDefaultBackground)
    }
}

#Preview {
    ProfileRead()
}
