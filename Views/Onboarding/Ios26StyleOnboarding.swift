//
//  Ios26StyleOnboarding.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//

import SwiftUI

struct Ios26StyleOnboarding: View {
    var tint: Color = .blue
    var items: [Item]
    // view properties
    @State private var currentIndex: Int = 0
    @State private var screenshotSize: CGSize = .zero

    var body: some View {
        ZStack(alignment: .bottom) {
            OnboardingScreenshotsView(items: items, currentIndex: currentIndex, screenshotSize: $screenshotSize)
                .compositingGroup()
                .scaleEffect(items[currentIndex].zoomScale, anchor: items[currentIndex].zoomAnchor)
                .padding(.top, 35)
                .padding(.horizontal, 30)
                .padding(.bottom, 220)

            VStack(spacing: 10) {
                OnboardingTextContentView(items: items, currentIndex: currentIndex)
                OnboardingIndicatorView(items: items, currentIndex: currentIndex)
                OnboardingContinueButton(itemCount: items.count, tint: tint, animation: animation, currentIndex: $currentIndex)
            }
            .padding(.top, 20)
            .padding(.horizontal, 15)
            .frame(height: 210)
            .background(GlassBlurBackground(radius: 15))

            if currentIndex == 0 {

            } else {
                withAnimation(animation) {
                    OnboardingBackButton(animation: animation, currentIndex: $currentIndex)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    // custom animation
    private var animation: Animation {
        .interpolatingSpring(duration: 0.65, bounce: 0, initialVelocity: 0)
    }
}

#Preview {
    ContentView()
}
