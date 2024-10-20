//
//  CalendarHeader.swift
//  FoodGo
//
//  Created by Alex.personal on 25/8/24.
//

import SwiftUI

struct CalendarHeader: View {
    let leftArrowAction: ImageTapAction?
    let rightArrowAction: ImageTapAction?
    @StateObject private var viewModel: CalendarViewModel
    
    init(viewModel: CalendarViewModel, leftArrowAction: ImageTapAction? = nil, rightArrowAction: ImageTapAction? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.leftArrowAction = leftArrowAction
        self.rightArrowAction = rightArrowAction
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            FoodGoImageView(
                resoureName: "arrow.left",
                width: 24,
                height: 12,
                action: leftArrowAction ?? { viewModel.goToPreviousMonth()
                })
            VStack {
                FoodGoTextView("\(viewModel.currentYear)", 10)
                FoodGoTextView(viewModel.monthName, 18)
            }
            
            FoodGoImageView(
                resoureName: "arrow.right",
                width: 24,
                height: 12,
                action: rightArrowAction ??  { viewModel.getNextMonth()
                }
            )
        }.onAppear {
            viewModel.getDaysInMonth()
        }
    }
}

#Preview {
    CalendarHeader(viewModel: CalendarViewModel())
}
