//
//  FoodGoTextField.swift
//  FoodGo
//
//  Created by Alex.personal on 4/9/24.
//

import SwiftUI

struct FoodGoTextField: View {
    let fontSize: CGFloat
    let placeHolder: String
    let foregroundColor: Color
    @Binding private var binding: String
    @FocusState private var hideKeyboard: Bool
    
    init(
        placeHolder: String,
        fontSize: CGFloat = 16,
        binding: Binding<String>,
        foregroundColor: Color = .black,
        hideKeyboard: FocusState<Bool>
    ) {
        self.placeHolder = placeHolder
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
        self._binding = binding
        self._hideKeyboard = hideKeyboard
    }
    
    var body: some View {
        TextField(placeHolder, text: $binding)
            .focused($hideKeyboard)
            .multilineTextAlignment(.center)
            .font(.custom("Questrial-Regular", size: fontSize))
            .foregroundStyle(foregroundColor)
    }
}

#Preview {
    FoodGoTextField(placeHolder: "placeholder", binding: .constant("my text"), hideKeyboard: .init())
}
