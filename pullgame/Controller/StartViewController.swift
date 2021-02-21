//
//  Startscreen.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/08/23.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit

class StartViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var startBtn: UIButton!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var timePlus: UIButton!
    @IBOutlet private var timeMinus: UIButton!

    private var sounds = Sounds()
    private var timeLimit = TimeLimit()

    override func viewDidLoad() {
        super.viewDidLoad()

        // フォントサイズの指定
        startBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        timePlus.titleLabel?.adjustsFontSizeToFitWidth = true
        timeMinus.titleLabel?.adjustsFontSizeToFitWidth = true

        startBtn.layer.borderWidth = 2

        checkTime()
    }

    @IBAction private func timePlus(_: Any) {
        timeLimit.plus()
        checkTime()
        playDecideSound()
    }

    @IBAction private func timeMinus(_: Any) {
        timeLimit.minus()
        checkTime()
        playDecideSound()
    }

    private func checkTime() {
        timeLabel.text = String(timeLimit.rawValue) + "sec"
        timeMinus.isHidden = timeLimit.ifTimeIsMinOrMax().min
        timePlus.isHidden = timeLimit.ifTimeIsMinOrMax().max
    }

    private func playDecideSound() {
        sounds.playSound(fileName: "decide", extentionName: "mp3")
    }

    // gameover画面に遷移する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            playDecideSound()
            UserDefaults.standard.set(timeLimit.rawValue, forKey: "Time")
        }
    }
}
