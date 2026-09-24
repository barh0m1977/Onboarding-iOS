//
//  GlassBlurBackground.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//

import SwiftUI

struct GlassBlurBackground: View {
    var radius: CGFloat

    var body: some View {
        let tintColor: Color = .black.opacity(0.5)
        Rectangle().fill(.clear)
            .glassEffect(.clear.tint(tintColor), in: .rect)
            .blur(radius: radius)
            .padding([.horizontal, .bottom], -radius * 2)
            .ignoresSafeArea()
    }
}
