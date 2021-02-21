//
//  GameState.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/12/16.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation

struct Location {
    var x : Int
    var y : Int
}

class PresentLocation {
    
    var state = [
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
    ]
    
    func getEmptyState() -> [[String]]{
        return
            [
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ]
    }
    
    ///何行目の、何列目(ボタンのtagで管理)のpresentかを返す
    func findLocation(tag: Int) -> Location {
        
        for (x,col) in state.enumerated(){
            if col[tag] != ""{
                return Location(x:x, y:tag)
            }
        }
        assertionFailure("Present is missing😢")
        abort()
    }
    
    
}

protocol ItemType {
    var imageName: String { get }
    var score: Int { get }
    var isBomb: Bool { get }
}

struct Apple: ItemType {
    let imageName = "apple"
    let score = 10
    var isBomb = false
}

struct Grape: ItemType {
    let imageName = "grape"
    let score = 20
    var isBomb = false
}

struct Melon: ItemType {
    let imageName = "melon"
    let score = 30
    var isBomb = false
}

struct Peach: ItemType {
    let imageName = "peach"
    let score = 40
    var isBomb = false
}

struct Banana: ItemType {
    let imageName = "banana"
    let score = 50
    var isBomb = false
}

struct Cherry: ItemType {
    let imageName = "cherry"
    let score = 60
    var isBomb = false
}

struct Diamond: ItemType {
    let imageName = "diamond"
    let score = 100
    var isBomb = false
}

struct Bomb: ItemType {
    let imageName = "bomb"
    let score = -50
    var isBomb = true
}

enum Player {
    case player1
    case player2
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

enum ItemPosition {
    case onBelt(ItemBeltPosition)
    case outOfBelt(Player)
}

struct BeltState {
    let item: ItemType
    let itemPosition: ItemPosition
}




func didTapDown(tappingPlayer: Player, beltState: BeltState) -> BeltState {
    let newItemPosition: ItemPosition
    
    switch beltState.itemPosition {
    case let .onBelt(position):
        switch tappingPlayer {
        case .player1:
            newItemPosition = position.next().map { ItemPosition.onBelt($0) }
                  ?? ItemPosition.outOfBelt(.player1)
        case .player2:
            newItemPosition = position.prev().map { ItemPosition.onBelt($0) }
                  ?? ItemPosition.outOfBelt(.player2)
        }
    case .outOfBelt:
        newItemPosition = beltState.itemPosition
    }

    return BeltState(item: beltState.item, itemPosition: newItemPosition)
}
