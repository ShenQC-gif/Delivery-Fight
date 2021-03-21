//
//  GameStatus.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/20.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

enum GameStatus: Equatable {
    case countDownBeforPlay(countDown: CountDownStatus)
    case onPlay
    case afterPlay

    static let firstStatus = GameStatus.countDownBeforPlay(countDown: .startingStatus)
}
