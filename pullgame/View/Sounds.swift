//
//  Sounds.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/11/11.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import Foundation

class Sounds {
    private var player: AVAudioPlayer?

    func playSound(rosource:Resource) {
        let soundURL = Bundle.main.url(forResource: rosource.filename, withExtension: rosource.extentionName)

        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
        } catch {
            print("error")
        }
    }
}

protocol Resource {
    var filename :String {get}
    var extentionName: String {get}
}

struct GetBomb :Resource {
    let filename: String = "bomb"
    let extentionName: String = "mp3"
}

struct GetPoint :Resource {
    let filename: String = "getPoint"
    let extentionName: String = "mp3"
}

struct Decide :Resource {
    let filename: String = "decide"
    let extentionName: String = "mp3"
}

struct CountDown :Resource {
    let filename: String = "countDown"
    let extentionName: String = "mp3"
}

struct Finish :Resource {
    let filename: String = "finish"
    let extentionName: String = "mp3"
}

