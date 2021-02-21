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
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timePlus: UIButton!
    @IBOutlet var timeMinus: UIButton!

    var sounds = Sounds()

    private var timeLimit = TimeLimit()
//    var settingTime = 30

    override func viewDidLoad() {
        super.viewDidLoad()

        // フォントサイズの指定
        startBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        timePlus.titleLabel?.adjustsFontSizeToFitWidth = true
        timeMinus.titleLabel?.adjustsFontSizeToFitWidth = true

        startBtn.layer.borderWidth = 2

        checkTime()
    }

    @IBAction func timeplus(_: Any) {
        timeLimit.plus()
        checkTime()
        playDecideSound()
    }

    @IBAction func timeminus(_: Any) {
        timeLimit.minus()
        checkTime()
        playDecideSound()
    }

    func checkTime() {
        timeLabel.text = String(timeLimit.rawValue) + "sec"
        timeMinus.isHidden = timeLimit.ifTimeIsMinOrMax().min
        timePlus.isHidden = timeLimit.ifTimeIsMinOrMax().max
    }

    func playDecideSound() {
        sounds.playSound(fileName: "decide", extentionName: "mp3")
    }

    // gameover画面に遷移する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            playDecideSound()
            let playscreen = segue.destination as! MainViewController
            playscreen.settingTime = timeLimit.rawValue
        }
    }
}
