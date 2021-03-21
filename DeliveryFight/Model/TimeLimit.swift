//
//  Timer.swift
//  DeliveryFight
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

    func plus() -> TimeLimit? {
        TimeLimit(rawValue: rawValue + 10)
    }

    func minus() -> TimeLimit? {
        TimeLimit(rawValue: rawValue - 10)
    }
}
