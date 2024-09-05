//
//  FoodGoProfile.swift
//  FoodGo
//
//  Created by Alex.personal on 3/9/24.
//

import SwiftUI

struct FoodGoProfile: View {
    @State var kg: String
    @State var height: String
    @State var pickerSelection: String
    @FocusState private var textFieldisFocused: Bool
    var body: some View {
        VStack {
            UserCardProfile(
                circleWidth: 150,
                circleHeight: 144,
                mainText: "Username",
                mainTextSize: 40
            ).padding(EdgeInsets(top: 48, leading: 0, bottom: 0, trailing: 0))
            VStack {
                HStack {
                    FoodGoTextView("Weight", 20, foregroundColor: .black)
                    Spacer()
                    FoodGoTextField(placeHolder: "kg", binding: $kg, hideKeyboard: _textFieldisFocused)
                }
                HStack {
                    FoodGoTextView("Height", 20, foregroundColor: .black)
                    Spacer()
                    FoodGoTextField(placeHolder: "Height", binding: $height, hideKeyboard: _textFieldisFocused)
                }
                
                HStack {
                    FoodGoTextView("Plan", 20, foregroundColor: .black)
                    Spacer()
                    Picker("PickerTitle", selection: $pickerSelection) {
                        Text("Loose weight")
                        Text("Gain weight")
                    }.pickerStyle(.inline)
                }
            }.padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            
            Spacer()
            
        }.onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    FoodGoProfile(kg: "", height: "", pickerSelection: "")
}
