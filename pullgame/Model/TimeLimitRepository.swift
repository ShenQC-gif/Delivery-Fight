//
//  TimeLimitRepository.swift
//  pullgame
//
//  Created by akio0911 on 2021/03/11.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

struct TimeLimitRepository {
    private static let key = "Time"

    func load() -> TimeLimit? {
        TimeLimit(rawValue: UserDefaults.standard.integer(forKey: Self.key))
    }

    func save(timeLimit: TimeLimit) {
        UserDefaults.standard.set(timeLimit.rawValue, forKey: "Time")
    }
}
