//
//  TransitionAnimationImageView.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import SwiftUI

struct TransitionAnimationImageView: UIViewRepresentable {
    typealias UIViewType = UIImageView

    var image: UIImage?

    func makeCoordinator() -> () {
        return
    }

    func makeUIView(context: UIViewRepresentableContext<TransitionAnimationImageView>) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<TransitionAnimationImageView>) {

        UIView.transition(with: uiView, duration: 1.0, options: [.transitionCrossDissolve, .curveEaseInOut], animations: {
            uiView.image = self.image
        })
    }
}
