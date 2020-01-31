//
//  Extensions.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import Foundation

extension Formatter {
    static let timeIntervalFormatter = { () -> NumberFormatter in
        let f = NumberFormatter()
        f.minimumFractionDigits = 1
        f.maximumFractionDigits = 1
        f.numberStyle = NumberFormatter.Style.decimal
        return f
    }()
}

extension NumberFormatter {
    func string(from number: TimeInterval) -> String {
        return self.string(from: NSNumber(value: number)) ?? ""
    }
}
