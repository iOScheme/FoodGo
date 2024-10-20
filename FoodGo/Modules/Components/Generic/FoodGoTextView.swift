//
//  FoodGoTextView.swift
//  FoodGo
//
//  Created by Alex.personal on 21/8/24.
//

import SwiftUI

struct FoodGoTextView: View {
    private let fontSize: CGFloat
    private let text: String
    private let foregroundColor: Color
    
    init(_ text: String, _ fontSize: CGFloat = 16, foregroundColor: Color = .black) {
        self.text = text
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        Text(text)
            .font(.custom("Questrial-Regular", size: fontSize))
            .foregroundStyle(foregroundColor)
    }
}

#Preview {
    FoodGoTextView("")
}
