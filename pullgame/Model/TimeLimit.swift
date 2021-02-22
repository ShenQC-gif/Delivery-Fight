//
//  Timer.swift
//  pullgame
//
//  Created by ちいつんしん on 2021/02/21.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

enum TimeLimit: Int {
    case ten = 10
    case twenty = 20
    case thirty = 30
    case forty = 40
    case fifty = 50
    case sixty = 60

    init() {
        self = .thirty
    }

    mutating func plus() {
        if let time = TimeLimit(rawValue: rawValue + 10) {
            self = time
        }
    }

    mutating func minus() {
        if let time = TimeLimit(rawValue: rawValue - 10) {
            self = time
        }
    }

    struct TimeLimitOption {
        let min: Bool
        let max: Bool
    }

    func ifTimeIsMinOrMax() -> TimeLimitOption {
        switch self {
        case .ten:
            return TimeLimitOption(min: true, max: false)
        case .twenty, .thirty, .forty, .fifty:
            return TimeLimitOption(min: false, max: false)
        case .sixty:
            return TimeLimitOption(min: false, max: true)
        }
    }
}
