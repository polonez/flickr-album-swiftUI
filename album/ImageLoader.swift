//
//  ImageLoader.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published private(set) var images: [ImageData] = []

    @Published var interval: TimeInterval {
        willSet {
            timer.interval = newValue
        }
    }

    private let albumService: AlbumServiceProtocol
    private let timer: CombineTimer

    private var cancelBag: [AnyCancellable] = []

    init(interval: TimeInterval, albumService: AlbumServiceProtocol) {
        self.interval = interval
        self.albumService = albumService
        timer = CombineTimer(interval: interval)
    }

    private func load() {
        albumService.fetchImageData()
            .compactMap { ImageData(data: $0.0, title: $0.1) }
            .print("fetch image data")
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (image) in
                self?.images.append(image)
            })
            .store(in: &cancelBag)
    }

    func start() {
        load()
        timer.publisher
            .print("timer")
            .sink { [weak self] (_) in
                let count = self?.images.count ?? 0
                if count > 0 {
                    self?.images.removeFirst()
                }
                if count < 5 {
                    self?.load()
                }
            }
            .store(in: &cancelBag)
    }

    func cancel() {
        NSLog("cancel")
        cancelBag.forEach { $0.cancel() }
        cancelBag = []
    }
}
