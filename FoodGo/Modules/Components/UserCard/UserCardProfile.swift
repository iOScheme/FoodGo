//
//  UserCardProfile.swift
//  FoodGo
//
//  Created by Alex.personal on 4/9/24.
//

import SwiftUI

struct UserCardProfile: View {
    let circleWidth: CGFloat
    let circleHeight: CGFloat
    let mainText: String
    let mainTextSize: CGFloat
    let placeHolder: String
    @Binding private var username: String
    @FocusState private var textFieldisFocused: Bool
    
    init(placeHolder: String, circleWidth: CGFloat, circleHeight: CGFloat, mainText: String, mainTextSize: CGFloat, username: Binding<String>) {
        self.placeHolder = placeHolder
        self.circleWidth = circleWidth
        self.circleHeight = circleHeight
        self.mainText = mainText
        self.mainTextSize = mainTextSize
        self._username = username
    }
    
    var body: some View {
        VStack {
            Circle().foregroundStyle(.gray)
                .frame(
                    width: circleWidth,
                    height: circleHeight
                )
            FoodGoTextField(
                placeHolder: placeHolder,
                fontSize: mainTextSize,
                binding: $username,
                hideKeyboard: _textFieldisFocused
            )
            .padding()
        }.onTapGesture {
            textFieldisFocused = false
        }
    }
}

#Preview {
    UserCardProfile(
        placeHolder: "Placegolder", circleWidth: 150,
        circleHeight: 144,
        mainText: "Welcome",
        mainTextSize: 40, username: .constant("Username")
    )
}
