//
//  GameState.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/12/16.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation

protocol ItemType {
    var imageName: String { get }
    var score: Int { get }
    var isBomb: Bool { get }
}

struct Apple: ItemType {
    let imageName = "apple"
    let score = 10
    let isBomb = false
}

struct Grape: ItemType {
    let imageName = "grape"
    let score = 20
    let isBomb = false
}

struct Melon: ItemType {
    let imageName = "melon"
    let score = 30
    let isBomb = false
}

struct Peach: ItemType {
    let imageName = "peach"
    let score = 40
    let isBomb = false
}

struct Banana: ItemType {
    let imageName = "banana"
    let score = 50
    let isBomb = false
}

struct Cherry: ItemType {
    let imageName = "cherry"
    let score = 60
    let isBomb = false
}

struct Diamond: ItemType {
    let imageName = "diamond"
    let score = 100
    let isBomb = false
}

struct Bomb: ItemType {
    let imageName = "bomb"
    let score = -50
    let isBomb = true
}
