//
//  AlbumView.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct AlbumView: View {
    @EnvironmentObject private var imageLoader: ImageLoader

    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                TransitionAnimationImageView(image: self.imageLoader.images.first?.image)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height * 0.8,
                           alignment: .center)
                    .scaledToFit()

                Text(self.imageLoader.images.first?.title ?? "")
                    .frame(width: geometry.size.width,
                           height: geometry.size.height * 0.2,
                           alignment: .center)
                    .foregroundColor(Color.black)
                }
            }

            Slider(value: $imageLoader.interval, in: 1...10)
                .padding(25)

            Text(Formatter.timeIntervalFormatter.string(from: imageLoader.interval))

        }
        .onAppear(perform: imageLoader.start)
        .onDisappear(perform: imageLoader.cancel)
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView().environmentObject(
            ImageLoader(interval: 3.0, albumService: AlbumService())
        )
    }
}
