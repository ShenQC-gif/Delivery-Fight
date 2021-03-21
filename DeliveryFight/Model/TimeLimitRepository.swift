//
//  TimeLimitRepository.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/14.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

struct TimeLimitRepository {
    private static let key = "Time"

    func load() -> TimeLimit? {
        return TimeLimit(rawValue: UserDefaults.standard.integer(forKey: Self.key))
    }

    func save(timeLimit: TimeLimit) {
        UserDefaults.standard.set(timeLimit.rawValue, forKey: Self.key)
    }
}
