//
//  Score.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/19.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

class Score {
    var score: Int

    init() {
        score = 0
    }

    func updateScore(item: ItemType) {
        score += item.score
    }

    func resetScore() {
        score = 0
    }
}
