//
//  BeltState.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/02/22.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

struct BeltState {
    let item: ItemType
    let itemPosition: ItemPosition
}

enum ItemBeltPosition {
    case pos0, pos1, pos2, pos3, pos4

    static let center = ItemBeltPosition.pos2

    func next() -> ItemBeltPosition? {
        switch self {
        case .pos0: return .pos1
        case .pos1: return .pos2
        case .pos2: return .pos3
        case .pos3: return .pos4
        case .pos4: return nil
        }
    }

    func prev() -> ItemBeltPosition? {
        switch self {
        case .pos0: return nil
        case .pos1: return .pos0
        case .pos2: return .pos1
        case .pos3: return .pos2
        case .pos4: return .pos3
        }
    }
}

enum ItemPosition: Equatable {
    case onBelt(ItemBeltPosition)
    case outOfBelt(Player)
}
