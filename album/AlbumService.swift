//
//  AlbumService.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import Foundation
import Combine

protocol AlbumServiceProtocol {
    func fetchImageData() -> AnyPublisher<(Data, String), Never>
}

final class AlbumService: AlbumServiceProtocol {
    private let session: URLSession = URLSession(configuration: .default)

    private let flickrUrl = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!

    private var publisher: AnyPublisher<(data: Data, response: URLResponse), URLError> {
        session.dataTaskPublisher(for: flickrUrl).eraseToAnyPublisher()
    }

    private func fetch(url: URL) -> AnyPublisher<Data, Never> {
        session.dataTaskPublisher(for: url).eraseToAnyPublisher()
            .map { (data, _) -> Data in
                data
            }
            .replaceError(with: Data())
            .eraseToAnyPublisher()
    }

    private func fetchImageUrls() -> AnyPublisher<[(URL, String)], Never> {
        return publisher
            .tryMap { (data, response) -> FlickrResponse in
                try JSONDecoder().decode(FlickrResponse.self, from: data)
            }
            .map { (flickrResponse) -> [(URL, String)] in
                let imageData = zip(flickrResponse.items.map { $0.media.m }, flickrResponse.items.map { $0.title })
                return imageData.map { ($0.0, $0.1) }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    private func fetchImages(urls: [URL]) -> AnyPublisher<Data, Never> {
        return Publishers.MergeMany(urls.map { fetch(url: $0) })
            .eraseToAnyPublisher()
    }

    func fetchImageData() -> AnyPublisher<(Data, String), Never> {
        fetchImageUrls()
            .flatMap { [unowned self] (imageData) -> AnyPublisher<(Data, String), Never> in
                return Publishers.Zip(
                    self.fetchImages(urls: imageData.map { $0.0 }),
                    Publishers.Sequence(sequence: imageData.map { $0.1 })
                        .eraseToAnyPublisher()
                    )
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
