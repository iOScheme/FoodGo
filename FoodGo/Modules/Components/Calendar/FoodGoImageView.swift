//
//  FoodGoImageView.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct FoodGoImageView: View {
    let resoureName: String
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        Image(resoureName)
            .frame(width: width, height: height)
    }
}

#Preview {
    FoodGoImageView(resoureName: "arrow.left", width: 24, height: 12)
}
