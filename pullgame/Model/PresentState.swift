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
}

enum ItemPosition {
    case onBelt(ItemBeltPosition)
    case outOfBelt(Player)
}

struct BeltState {
    let item: ItemType
    let itemPosition: ItemPosition
}

var beltStates: [BeltState] = [
    BeltState(item: Apple(), itemPosition: .onBelt(.center)),
    BeltState(item: Bomb(), itemPosition: .onBelt(.center)),
    BeltState(item: Apple(), itemPosition: .onBelt(.center)),
    BeltState(item: Bomb(), itemPosition: .onBelt(.center)),
    BeltState(item: Apple(), itemPosition: .onBelt(.center)),
]

func configureUI(beltStates: [BeltState]) {
    // ここでUIを適切に設定する
}
