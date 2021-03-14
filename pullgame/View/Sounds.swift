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

    private func playSound(fileName: String, extentionName: String) {
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: extentionName)

        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
        } catch {
            print("error")
        }
    }
}

extension Sounds{

    func playDecide(){
        playSound(fileName: "decide", extentionName: "mp3")
    }

    func playBomb(){
        playSound(fileName: "bomb", extentionName: "mp3")
    }

    func playGetPoint(){
        playSound(fileName: "getPoint", extentionName: "mp3")
    }

    func playCountDown(){
        playSound(fileName: "countDown", extentionName: "mp3")
    }

    func playFinish(){
        playSound(fileName: "finish", extentionName: "mp3")
    }
}
