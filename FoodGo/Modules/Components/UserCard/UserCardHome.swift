//
//  UserCard.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct UserCardHome: View {
    let circleWidth: CGFloat
    let circleHeight: CGFloat
    let mainText: String
    let secondaryText: String?
    let mainTextSize: CGFloat
    let secondaryTextSize: CGFloat?
    
    init(circleWidth: CGFloat, circleHeight: CGFloat, mainText: String, secondaryText: String?, mainTextSize: CGFloat, secondaryTextSize: CGFloat?) {
        self.circleWidth = circleWidth
        self.circleHeight = circleHeight
        self.mainText = mainText
        self.secondaryText = secondaryText
        self.mainTextSize = mainTextSize
        self.secondaryTextSize = secondaryTextSize
    }
    var body: some View {
        HStack {
            Circle().foregroundStyle(.gray)
                .frame(width: circleWidth, height: circleHeight)
            Spacer(minLength: 16)
            VStack {
                FoodGoTextView(mainText, mainTextSize).frame(maxWidth: .infinity, alignment: .leading)
                if let secondaryText = secondaryText, let secondaryTextSize = secondaryTextSize{
                    FoodGoTextView(secondaryText, secondaryTextSize).frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    UserCardHome(
        circleWidth: 52,
        circleHeight: 59,
        mainText: "Welcome",
        secondaryText: "User",
        mainTextSize: 20,
        secondaryTextSize: 16
    )
}
