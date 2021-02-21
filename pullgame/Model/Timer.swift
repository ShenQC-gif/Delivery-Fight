//
//  Timer.swift
//  pullgame
//
//  Created by ちいつんしん on 2021/02/21.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

enum Time : Int {

    case ten = 10
    case twenty = 20
    case thirty = 30
    case forty = 40
    case fifty = 50
    case sixty = 60

    init(){
        self = .thirty
    }


    mutating func plus(){

        if let time = Time(rawValue: rawValue + 10){
            self = time
        }
    }

    mutating func minus(){

        if let time = Time(rawValue: rawValue - 10){
            self = time
        }

    }


}
