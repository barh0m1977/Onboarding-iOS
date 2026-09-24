//
//  OnboardingScreenshotsView.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//

import SwiftUI

struct OnboardingScreenshotsView: View {
    var items: [Item]
    var currentIndex: Int
    @Binding var screenshotSize: CGSize

    private var deviceCornerRadius: CGFloat {
        if let imageSize = items.first?.snapshot?.size {
            let ratio = screenshotSize.height / imageSize.height
            let cornerRadius: CGFloat = 190
            return cornerRadius * ratio
        }
        return 0
    }

    var body: some View {
        let shape = ConcentricRectangle(corners: .concentric, isUniform: true)
        GeometryReader {
            let size = $0.size
            Rectangle().fill(.black)
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        Group {
                            if let screenshots = item.snapshot {
                                Image(uiImage: screenshots)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onGeometryChange(for: CGSize.self) {
                                        $0.size
                                    } action: { newValue in
                                        screenshotSize = newValue
                                    }
                                    .clipShape(shape)
                            } else {
                                Rectangle()
                                    .fill(.black)
                            }
                        }
                        .frame(width: size.width, height: size.height)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollDisabled(true)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollPosition(id: .init(get: {
                return currentIndex
            }, set: { _ in

            }))
        }
        .clipShape(shape)
        .overlay {
            if screenshotSize != .zero {
                // Iphone Device Frame UI
                ZStack {
                    shape
                        .stroke(.white, lineWidth: 6)
                    shape
                        .stroke(.black, lineWidth: 4)
                    shape
                        .stroke(.black, lineWidth: 6)
                        .padding(4)
                }
                .padding(-6)
            }
        }
        .frame(maxWidth: screenshotSize.width == 0 ? nil : screenshotSize.width,
               maxHeight: screenshotSize.height == 0 ? nil : screenshotSize.height)
        .containerShape(RoundedRectangle(cornerRadius: deviceCornerRadius))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
