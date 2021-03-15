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
