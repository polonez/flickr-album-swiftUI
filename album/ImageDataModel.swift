//
//  ImageDataModel.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import UIKit
import Combine

final class ImageData: ObservableObject {
    let image: UIImage
    let title: String

    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }

    init?(data: Data, title: String) {
        guard let image = UIImage(data: data) else { return nil }
        self.image = image
        self.title = title
    }
}

extension ImageData: Equatable {
    static func == (lhs: ImageData, rhs: ImageData) -> Bool {
        return lhs.image == rhs.image && lhs.title == rhs.title
    }
}
