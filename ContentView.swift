//
//  ContentView.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let image = UIImage(named:"screenshot")
        let title = "welcom iOS 26 "
        let subTitle = "new one is here , liquid Glass try it.  "
        
        Ios26StyleOnboarding(items: [
            .init(id: 0, title: title, subTitle: subTitle,snapshot: image,zoomScale: 1.3, zoomAnchor: .top),
            .init(id: 1, title: title, subTitle: subTitle,snapshot: image),
            .init(id: 2, title: title, subTitle: subTitle,snapshot: image),
            .init(id: 4, title: title, subTitle: subTitle,snapshot: image,zoomScale: 1.3, zoomAnchor: .bottom),
    
        ])
    }
}

#Preview {
    ContentView()
}
