//
//  UserCard.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct UserCard: View {
    var body: some View {
        HStack {
            Circle().foregroundStyle(.gray)
                .frame(width: 52, height: 59)
            VStack {
                FoodGoTextView("Welcome", 20).frame(maxWidth: .infinity, alignment: .leading)
                FoodGoTextView("User", 16).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    UserCard()
}
