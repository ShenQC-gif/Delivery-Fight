//
//  GameResult.swift
//  pullgame
//
//  Created by akio0911 on 2021/03/11.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

enum GameResult {
    case win
    case lose
    case draw

    var enemyResult: GameResult {
        switch self {
        case .win: return .lose
        case .lose: return .win
        case .draw: return .draw
        }
    }
}
