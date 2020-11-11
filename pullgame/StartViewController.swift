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

    @IBOutlet var appleView: UIImageView!
    @IBOutlet var grapeView: UIImageView!
    @IBOutlet var melonView: UIImageView!
    @IBOutlet var peachView: UIImageView!
    @IBOutlet var bananaView: UIImageView!
    @IBOutlet var cherryView: UIImageView!
    @IBOutlet var diamondView: UIImageView!
    @IBOutlet var bombView: UIImageView!

    @IBOutlet var appleLabel: UILabel!
    @IBOutlet var grapeLabel: UILabel!
    @IBOutlet var melonLabel: UILabel!
    @IBOutlet var peachLabel: UILabel!
    @IBOutlet var bananaLabel: UILabel!
    @IBOutlet var cherryLabel: UILabel!
    @IBOutlet var diamondLabel: UILabel!
    @IBOutlet var bombLabel: UILabel!

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timePlus: UIButton!
    @IBOutlet var timeMinus: UIButton!

    var decidePlayer: AVAudioPlayer!
    var timerUpDownPlayer: AVAudioPlayer!

    var settingTime = 30

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    override func viewDidLoad() {
        super.viewDidLoad()

        // 再生する audio ファイルのパスを取得
        let decidePath = Bundle.main.path(forResource: "decide", ofType: "mp3")!
        let decideUrl = URL(fileURLWithPath: decidePath)

        // auido を再生するプレイヤーを作成する
        var audioError: NSError?
        do {
            decidePlayer = try AVAudioPlayer(contentsOf: decideUrl)


        } catch let error as NSError {
            audioError = error
            decidePlayer = nil

        }

        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }

        decidePlayer.delegate = self
        decidePlayer.prepareToPlay()


        titleLabel.frame = CGRect(x: width * 1.5 / 32, y: height * 1.5 / 34, width: width * 29 / 32, height: height * 6 / 34)
        
        startBtn.frame = CGRect(x: width * 3.5 / 12, y: height * 29.5 / 34, width: width * 5 / 12, height: height * 3 / 34)

        timeLabel.frame = CGRect(x: 0, y: height * 25 / 34, width: width, height: height * 3 / 34)
        timePlus.frame = CGRect(x: width * 9 / 12, y: height * 25 / 34, width: width * 1 / 12, height: height * 3 / 34)
        timeMinus.frame = CGRect(x: width * 2 / 12, y: height * 25 / 34, width: width * 1 / 12, height: height * 3 / 34)

        appleView.frame = CGRect(x: width * 1 / 20, y: height * 8 / 34, width: width * 4 / 18, height: height * 3 / 34)
        grapeView.frame = CGRect(x: width * 1 / 20, y: height * 12 / 34, width: width * 4 / 18, height: height * 3 / 34)
        melonView.frame = CGRect(x: width * 1 / 20, y: height * 16 / 34, width: width * 4 / 18, height: height * 3 / 34)
        peachView.frame = CGRect(x: width * 1 / 20, y: height * 20 / 34, width: width * 4 / 18, height: height * 3 / 34)
        bananaView.frame = CGRect(x: width * 11 / 20, y: height * 8 / 34, width: width * 4 / 18, height: height * 3 / 34)
        cherryView.frame = CGRect(x: width * 11 / 20, y: height * 12 / 34, width: width * 4 / 18, height: height * 3 / 34)
        diamondView.frame = CGRect(x: width * 11 / 20, y: height * 16 / 34, width: width * 4 / 18, height: height * 3 / 34)
        bombView.frame = CGRect(x: width * 11 / 20, y: height * 20 / 34, width: width * 4 / 18, height: height * 3 / 34)

        appleLabel.frame = CGRect(x: width * 6 / 20, y: height * 8.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        grapeLabel.frame = CGRect(x: width * 6 / 20, y: height * 12.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        melonLabel.frame = CGRect(x: width * 6 / 20, y: height * 16.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        peachLabel.frame = CGRect(x: width * 6 / 20, y: height * 20.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        bananaLabel.frame = CGRect(x: width * 16 / 20, y: height * 8.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        cherryLabel.frame = CGRect(x: width * 16 / 20, y: height * 12.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        diamondLabel.frame = CGRect(x: width * 16 / 20, y: height * 16.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        bombLabel.frame = CGRect(x: width * 16 / 20, y: height * 20.5 / 34, width: width * 2 / 18, height: height * 2 / 34)

        // フォントサイズの指定
        startBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        timePlus.titleLabel?.adjustsFontSizeToFitWidth = true
        timeMinus.titleLabel?.adjustsFontSizeToFitWidth = true

        startBtn.layer.borderWidth = 2

        checkTime()
    }

    @IBAction func timeplus(_: Any) {
        settingTime += 10
        checkTime()
    }

    @IBAction func timeminus(_: Any) {
        settingTime -= 10
        checkTime()
    }

    func checkTime() {
        timeLabel.text = String(settingTime) + "sec"

        if settingTime == 10 {
            timeMinus.isHidden = true
        } else if settingTime == 60 {
            timePlus.isHidden = true
        } else {
            timeMinus.isHidden = false
            timePlus.isHidden = false
        }
    }

    @IBAction func start(_: Any) {
        decidePlayer.play()
    }

    @IBAction func timerUpDown(_: Any) {
        // 音量調整の音源を0秒に戻す
        decidePlayer.currentTime = 0
        decidePlayer.play()
    }

    // gameover画面に遷移する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            let playscreen = segue.destination as! MainViewController
            playscreen.settingTime = settingTime
        }
    }
}
