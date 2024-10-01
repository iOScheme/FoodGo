//
//  MealSuggestionCard.swift
//  FoodGo
//
//  Created by Alex.personal on 23/9/24.
//

import SwiftUI

struct MealSuggestionCard: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(
                    width: 148,
                    height: 165
                ).cornerRadius(30)
            FoodGoTextView("Arros Basmati")
            FoodGoTextView("128 Kcal",foregroundColor: .red)
        }
       
    }
}

#Preview {
    MealSuggestionCard()
}
