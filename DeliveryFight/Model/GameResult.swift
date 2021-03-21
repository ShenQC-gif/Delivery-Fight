//
//  GameResult.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/14.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

enum GameResult {
    case win
    case lose
    case draw

    func opponentResult() -> GameResult {
        switch self {
        case .win:
            return .lose
        case .lose:
            return .win
        case .draw:
            return .draw
        }
    }
}
