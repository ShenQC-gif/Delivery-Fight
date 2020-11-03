//
//  Startscreen.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/08/23.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit

class Startscreen: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet var titlelabel: UILabel!
    @IBOutlet var startbtn: UIButton!

    @IBOutlet var appleview: UIImageView!
    @IBOutlet var grapeview: UIImageView!
    @IBOutlet var melonview: UIImageView!
    @IBOutlet var peachview: UIImageView!
    @IBOutlet var bananaview: UIImageView!
    @IBOutlet var cherryview: UIImageView!
    @IBOutlet var diamondview: UIImageView!
    @IBOutlet var bombview: UIImageView!

    @IBOutlet var applelabel: UILabel!
    @IBOutlet var grapelabel: UILabel!
    @IBOutlet var melonlabel: UILabel!
    @IBOutlet var peachlabel: UILabel!
    @IBOutlet var bananalabel: UILabel!
    @IBOutlet var cherrylabel: UILabel!
    @IBOutlet var diamondlabel: UILabel!
    @IBOutlet var bomblabel: UILabel!

    @IBOutlet var timelabel: UILabel!
    @IBOutlet var timeplus: UIButton!
    @IBOutlet var timeminus: UIButton!

    var decidePlayer: AVAudioPlayer!
    var timerupdownPlayer: AVAudioPlayer!

    var settingtime = 30

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


        titlelabel.frame = CGRect(x: width * 1.5 / 32, y: height * 1.5 / 34, width: width * 29 / 32, height: height * 6 / 34)
        startbtn.frame = CGRect(x: width * 3.5 / 12, y: height * 29.5 / 34, width: width * 5 / 12, height: height * 3 / 34)

        timelabel.frame = CGRect(x: 0, y: height * 25 / 34, width: width, height: height * 3 / 34)
        timeplus.frame = CGRect(x: width * 9 / 12, y: height * 25 / 34, width: width * 1 / 12, height: height * 3 / 34)
        timeminus.frame = CGRect(x: width * 2 / 12, y: height * 25 / 34, width: width * 1 / 12, height: height * 3 / 34)

        appleview.frame = CGRect(x: width * 1 / 20, y: height * 8 / 34, width: width * 4 / 18, height: height * 3 / 34)
        grapeview.frame = CGRect(x: width * 1 / 20, y: height * 12 / 34, width: width * 4 / 18, height: height * 3 / 34)
        melonview.frame = CGRect(x: width * 1 / 20, y: height * 16 / 34, width: width * 4 / 18, height: height * 3 / 34)
        peachview.frame = CGRect(x: width * 1 / 20, y: height * 20 / 34, width: width * 4 / 18, height: height * 3 / 34)
        bananaview.frame = CGRect(x: width * 11 / 20, y: height * 8 / 34, width: width * 4 / 18, height: height * 3 / 34)
        cherryview.frame = CGRect(x: width * 11 / 20, y: height * 12 / 34, width: width * 4 / 18, height: height * 3 / 34)
        diamondview.frame = CGRect(x: width * 11 / 20, y: height * 16 / 34, width: width * 4 / 18, height: height * 3 / 34)
        bombview.frame = CGRect(x: width * 11 / 20, y: height * 20 / 34, width: width * 4 / 18, height: height * 3 / 34)

        applelabel.frame = CGRect(x: width * 6 / 20, y: height * 8.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        grapelabel.frame = CGRect(x: width * 6 / 20, y: height * 12.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        melonlabel.frame = CGRect(x: width * 6 / 20, y: height * 16.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        peachlabel.frame = CGRect(x: width * 6 / 20, y: height * 20.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        bananalabel.frame = CGRect(x: width * 16 / 20, y: height * 8.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        cherrylabel.frame = CGRect(x: width * 16 / 20, y: height * 12.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        diamondlabel.frame = CGRect(x: width * 16 / 20, y: height * 16.5 / 34, width: width * 2 / 18, height: height * 2 / 34)
        bomblabel.frame = CGRect(x: width * 16 / 20, y: height * 20.5 / 34, width: width * 2 / 18, height: height * 2 / 34)

        // フォントサイズの指定
        startbtn.titleLabel?.adjustsFontSizeToFitWidth = true
        timeplus.titleLabel?.adjustsFontSizeToFitWidth = true
        timeminus.titleLabel?.adjustsFontSizeToFitWidth = true

        startbtn.layer.borderWidth = 2

        checktime()
    }

    @IBAction func timeplus(_: Any) {
        settingtime += 10
        checktime()
    }

    @IBAction func timeminus(_: Any) {
        settingtime -= 10
        checktime()
    }

    func checktime() {
        timelabel.text = String(settingtime) + "sec"

        if settingtime == 10 {
            timeminus.isHidden = true
        } else if settingtime == 60 {
            timeplus.isHidden = true
        } else {
            timeminus.isHidden = false
            timeplus.isHidden = false
        }
    }

    @IBAction func start(_: Any) {
        decidePlayer.play()
    }

    @IBAction func timerupdown(_: Any) {
        // 音量調整の音源を0秒に戻す
        decidePlayer.currentTime = 0
        decidePlayer.play()
    }

    // gameover画面に遷移する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toplayscreen" {
            let playscreen = segue.destination as! ViewController
            playscreen.settingtime = settingtime
        }
    }
}
