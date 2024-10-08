//
//  FoodGoProfile.swift
//  FoodGo
//
//  Created by Alex.personal on 3/9/24.
//

import SwiftUI
import SwiftData

struct FoodGoProfile: View {
    @State private var kg: String
    @State private var height: String
    @State private var pickerSelection: UserPlan
    @State private var username: String
    @State private var toggleIsOn: Bool
    init(kg: String, height: String, pickerSelection: UserPlan, username: String) {
        self.kg = kg
        self.height = height
        self.pickerSelection = pickerSelection
        self.username = username
        self._toggleIsOn = .init(initialValue: false)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer().layoutPriority(1)
                Toggle("Edit", isOn: $toggleIsOn).layoutPriority(1)
                Spacer().layoutPriority(1)
            }.padding()
            
            if !toggleIsOn {
                ProfileRead()
            } else {
                ProfileEdit(
                    kg: $kg,
                    height: $height,
                    pickerSelection: $pickerSelection,
                    username: $username
                )
            }
        }
    }
}

#Preview {
    FoodGoProfile(kg: "", height: "", pickerSelection: .gainWeight, username: "")
}
