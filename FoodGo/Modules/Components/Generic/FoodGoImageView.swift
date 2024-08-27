//
//  FoodGoImageView.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

typealias ImageTapAction = () -> Void
struct FoodGoImageView: View {
    let resoureName: String
    let width: CGFloat
    let height: CGFloat
    let action: ImageTapAction?
    
    init(resoureName: String, width: CGFloat, height: CGFloat, action: ImageTapAction? = nil) {
        self.resoureName = resoureName
        self.width = width
        self.height = height
        self.action = action
    }
    var body: some View {
        Image(resoureName)
            .frame(width: width, height: height)
            .onTapGesture {
                action?()
            }
    }
}

#Preview {
    FoodGoImageView(resoureName: "arrow.left", width: 24, height: 12)
}
