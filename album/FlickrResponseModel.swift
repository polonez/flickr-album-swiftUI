//
//  FlickrResponseModel.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import Foundation

struct FlickrMediaItem: Codable {
    let m: URL
}

struct FlickrResponseItem: Codable {
    let title: String
    let media: FlickrMediaItem
    let date_taken: String
    let published: String
}

struct FlickrResponse: Codable {
    let items: [FlickrResponseItem]
}
