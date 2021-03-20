//
//  CountDown.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/20.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

enum CountDownStatus : Int{
    case three = 3
    case two = 2
    case one = 1

    static let startingStatus = CountDownStatus.three
}
