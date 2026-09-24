//
//  OnboardingContinueButton.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//

import SwiftUI

struct OnboardingContinueButton: View {
    var itemCount: Int
    var tint: Color
    var animation: Animation
    @Binding var currentIndex: Int

    var body: some View {
        Button {
            withAnimation(animation) {
                currentIndex = min(currentIndex + 1, itemCount - 1)
            }
        } label: {
            Text("continue")
                .fontWeight(.medium)
                .padding(.vertical, 6)
        }
        .tint(tint)
        .buttonStyle(.glassProminent)
        .buttonSizing(.flexible)
        .padding(.horizontal, 30)
    }
}
