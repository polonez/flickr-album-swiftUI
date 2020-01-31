//
//  MainView.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var imageLoader = ImageLoader(
        interval: 2.0,
        albumService: AlbumService()
    )

    var body: some View {
        NavigationView {
            VStack {
                Text("Flickr Album")
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 100, trailing: 10))
                Slider(value: $imageLoader.interval, in: 1...10)
                    .padding(25)
                Text(Formatter.timeIntervalFormatter.string(from: imageLoader.interval))
                NavigationLink(destination: AlbumView()
                    .environmentObject(imageLoader)
                ) {
                    Text("Start")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 8", "iPhone XS Max", "iPad Pro (12.9-inch)"], id: \.self) { deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
