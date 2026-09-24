# iOS 26 Style Onboarding

A SwiftUI onboarding screen built with iOS 26's **Liquid Glass** design language — a device-framed screenshot carousel, animated title/subtitle text, page indicator dots, and glass-style navigation buttons, all driven by a single spring animation.

Drop it into any app to get an animated, swipeable-feeling (button-driven) onboarding flow in a few lines of code.

## Demo

<video src="./Demo.mov" controls width="360"></video>

## Features

- **Device-frame screenshot carousel** — screenshots are clipped into a concentric rounded rectangle with an iPhone-style bezel drawn around it, sized automatically from the image itself.
- **Per-page zoom** — each onboarding page can zoom into a different part of its screenshot (`zoomScale` + `zoomAnchor`), useful for drawing attention to a specific UI element in the screenshot.
- **Animated text carousel** — title/subtitle blur and fade out as they leave the active page, then sharpen back in.
- **Page indicator dots** that grow to show the active page.
- **Glass button controls** — a `continue` button (`.glassProminent`) that advances the flow, and a circular back button (`.glass`) that appears once you're past the first page.
- **Glass blur background** behind the text/controls panel using `glassEffect`.
- **One spring animation** (`interpolatingSpring`) drives every transition, so paging always feels consistent.

## Requirements

- iOS 26.5+ / Xcode 16+ (uses `ConcentricRectangle`, `glassEffect`, `.buttonStyle(.glassProminent)`, `.buttonStyle(.glass)` — all part of the Liquid Glass API set)
- Swift 5 / SwiftUI

## Project structure

```
OnBoarding/
├── OnBoardingApp.swift                     # @main entry point
├── ContentView.swift                       # example usage — builds the onboarding pages
├── Models/
│   └── Item.swift                          # one onboarding page (title, subtitle, screenshot, zoom)
└── Views/Onboarding/
    ├── Ios26StyleOnboarding.swift           # container — owns paging state, composes the pieces below
    └── Components/
        ├── OnboardingScreenshotsView.swift  # device-frame screenshot carousel
        ├── OnboardingTextContentView.swift  # title/subtitle carousel
        ├── OnboardingIndicatorView.swift    # page dots
        ├── OnboardingContinueButton.swift   # "continue" button
        ├── OnboardingBackButton.swift       # back button
        └── GlassBlurBackground.swift        # glass blur panel behind the text/controls
```

## Usage

Each page is an `Item`:

```swift
struct Item: Identifiable {
    var id: Int
    var title: String
    var subTitle: String
    var snapshot: UIImage?
    var zoomScale: CGFloat = 1        // optional — zoom into the screenshot
    var zoomAnchor: UnitPoint = .center // optional — where the zoom anchors from
}
```

Build a list of `Item`s and hand them to `Ios26StyleOnboarding`:

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        let image = UIImage(named: "screenshot")
        let title = "Welcome to iOS 26"
        let subTitle = "A new look, built with Liquid Glass."

        Ios26StyleOnboarding(items: [
            .init(id: 0, title: title, subTitle: subTitle, snapshot: image, zoomScale: 1.3, zoomAnchor: .top),
            .init(id: 1, title: title, subTitle: subTitle, snapshot: image),
            .init(id: 2, title: title, subTitle: subTitle, snapshot: image),
            .init(id: 3, title: title, subTitle: subTitle, snapshot: image, zoomScale: 1.3, zoomAnchor: .bottom),
        ])
    }
}
```

That's it — `Ios26StyleOnboarding` manages its own paging state (`currentIndex`) internally; you just supply the pages.

### Customizing the tint

The continue button's tint defaults to `.blue`. Override it via the `tint` parameter:

```swift
Ios26StyleOnboarding(tint: .orange, items: pages)
```

### Adding screenshots

Add each screenshot as an image set in `Assets.xcassets` and reference it by name with `UIImage(named:)` when building your `Item` list. If an item's `snapshot` is `nil`, that page renders a plain black placeholder instead of crashing.

## How it works

- `Ios26StyleOnboarding` is the only stateful piece — it owns `currentIndex` (which page is active) and `screenshotSize` (measured from the current screenshot, used to size the device bezel).
- The screenshot carousel and text carousel are visually driven by `currentIndex`, not actual scroll gestures — user swiping is disabled, so paging only happens through the continue/back buttons. This keeps the whole flow (image scale, blur/fade text, indicator dots) perfectly in sync.
- `OnboardingContinueButton` and `OnboardingBackButton` mutate `currentIndex` inside `withAnimation(_:)` using the shared spring animation, so every page change animates consistently across all components.
