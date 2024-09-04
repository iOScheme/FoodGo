//
//  FoodGoProfile.swift
//  FoodGo
//
//  Created by Alex.personal on 3/9/24.
//

import SwiftUI

struct FoodGoProfile: View {
    var body: some View {
        VStack {
            UserCardProfile(
                circleWidth: 150,
                circleHeight: 144,
                mainText: "Username",
                mainTextSize: 40
            ).padding(EdgeInsets(top: 48, leading: 0, bottom: 0, trailing: 0))
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    FoodGoProfile()
}
