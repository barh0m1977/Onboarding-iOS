//
//  OnboardingTextContentView.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//

import SwiftUI

struct OnboardingTextContentView: View {
    var items: [Item]
    var currentIndex: Int

    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]
                        let isActive = currentIndex == index
                        VStack(spacing: 6) {
                            Text(item.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .foregroundStyle(.white)

                            Text(item.subTitle)
                                .font(.callout)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .frame(width: size.width)
                        .compositingGroup()
                        .blur(radius: isActive ? 0 : 30)
                        .opacity(isActive ? 1 : 0)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .scrollClipDisabled()
            .scrollPosition(id: .init(get: {
                return currentIndex
            }, set: { _ in

            }))
        }
    }
}
