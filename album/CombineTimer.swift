//
//  CombineTimer.swift
//  album
//
//  Created by Fred on 2020/01/25.
//  Copyright © 2020 etude. All rights reserved.
//

import Foundation
import Combine

final class CombineTimer {
    private let intervalSubject: CurrentValueSubject<TimeInterval, Never>

    var interval: TimeInterval {
        get {
            intervalSubject.value
        }
        set {
            intervalSubject.send(newValue)
        }
    }

    var publisher: AnyPublisher<Date, Never> {
        intervalSubject.map {
            Timer.TimerPublisher(interval: $0, runLoop: .current, mode: RunLoop.Mode.default)
                .autoconnect()
                .print("timer")
        }
        .switchToLatest()
        .print("new timer")
        .eraseToAnyPublisher()
    }

    init(interval: TimeInterval) {
        self.intervalSubject = CurrentValueSubject<TimeInterval, Never>(interval)
    }
}
