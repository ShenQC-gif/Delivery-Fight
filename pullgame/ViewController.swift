//
//  ViewController.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/08/22.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet var conveyor1: UIImageView!
    @IBOutlet var conveyor2: UIImageView!
    @IBOutlet var conveyor3: UIImageView!
    @IBOutlet var conveyor4: UIImageView!
    @IBOutlet var conveyor5: UIImageView!

    @IBOutlet var pullbtn11: UIButton!
    @IBOutlet var pullbtn12: UIButton!
    @IBOutlet var pullbtn13: UIButton!
    @IBOutlet var pullbtn14: UIButton!
    @IBOutlet var pullbtn15: UIButton!

    @IBOutlet var pushbtn11: UIButton!
    @IBOutlet var pushbtn12: UIButton!
    @IBOutlet var pushbtn13: UIButton!
    @IBOutlet var pushbtn14: UIButton!
    @IBOutlet var pushbtn15: UIButton!

    @IBOutlet var pullbtn21: UIButton!
    @IBOutlet var pullbtn22: UIButton!
    @IBOutlet var pullbtn23: UIButton!
    @IBOutlet var pullbtn24: UIButton!
    @IBOutlet var pullbtn25: UIButton!

    @IBOutlet var pushbtn21: UIButton!
    @IBOutlet var pushbtn22: UIButton!
    @IBOutlet var pushbtn23: UIButton!
    @IBOutlet var pushbtn24: UIButton!
    @IBOutlet var pushbtn25: UIButton!

    @IBOutlet var pointlabel1: UILabel!
    @IBOutlet var pointlabel2: UILabel!

    @IBOutlet var timerlabel1: UILabel!
    @IBOutlet var timerlabel2: UILabel!

    @IBOutlet var winloselabel1: UILabel!
    @IBOutlet var winloselabel2: UILabel!

    @IBOutlet var calllabel: UILabel!

    @IBOutlet var againbtn: UIButton!
    @IBOutlet var homebtn: UIButton!

    var present1 = UIImageView()
    var present2 = UIImageView()
    var present3 = UIImageView()
    var present4 = UIImageView()
    var present5 = UIImageView()

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    var countdownPlayer: AVAudioPlayer!
    var getpointPlayer: AVAudioPlayer!
    var bombPlayer: AVAudioPlayer!
    var finishPlayer: AVAudioPlayer!
    var decidePlayer: AVAudioPlayer!

    var pointnum1 = 0
    var pointnum2 = 0

    var settingtime = 0
    var resttime = 0

    var timer = Timer()

    var transRotate1 = CGAffineTransform()
    var transRotate2 = CGAffineTransform()

    // btnを1列ごとに管理
    var btnline1: [UIButton] = []
    var btnline2: [UIButton] = []
    var btnline3: [UIButton] = []
    var btnline4: [UIButton] = []
    var btnline5: [UIButton] = []

    // present名を管理
    var presentarray: [String] = []

    var presentviewarray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        btnline1 = [pullbtn11, pushbtn11, pushbtn21, pullbtn21]
        btnline2 = [pullbtn12, pushbtn12, pushbtn22, pullbtn22]
        btnline3 = [pullbtn13, pushbtn13, pushbtn23, pullbtn23]
        btnline4 = [pullbtn14, pushbtn14, pushbtn24, pullbtn24]
        btnline5 = [pullbtn15, pushbtn15, pushbtn25, pullbtn25]

        presentviewarray = [present1, present2, present3, present4, present5]

        presentarray = ["apple", "grape", "melon", "peach", "banana", "cherry", "diamond", "bomb", "bomb"]

        // 再生する audio ファイルのパスを取得
        let countdownPath = Bundle.main.path(forResource: "countdown", ofType: "mp3")!
        let countdownUrl = URL(fileURLWithPath: countdownPath)

        let getpointPath = Bundle.main.path(forResource: "getpoint", ofType: "mp3")!
        let getpointUrl = URL(fileURLWithPath: getpointPath)

        let bombPath = Bundle.main.path(forResource: "bomb", ofType: "mp3")!
        let bombUrl = URL(fileURLWithPath: bombPath)

//        let finishPath = Bundle.main.path(forResource: "finish", ofType: "mp3")!
//        let finishUrl = URL(fileURLWithPath: finishPath)

        let decidePath = Bundle.main.path(forResource: "decide", ofType: "mp3")!
        let decideUrl = URL(fileURLWithPath: decidePath)

        // auido を再生するプレイヤーを作成する
        var audioError: NSError?
        do {
            countdownPlayer = try AVAudioPlayer(contentsOf: countdownUrl)
            getpointPlayer = try AVAudioPlayer(contentsOf: getpointUrl)
            bombPlayer = try AVAudioPlayer(contentsOf: bombUrl)
//            finishPlayer = try AVAudioPlayer(contentsOf: finishUrl)
            decidePlayer = try AVAudioPlayer(contentsOf: decideUrl)

        } catch let error as NSError {
            audioError = error
            countdownPlayer = nil
            getpointPlayer = nil
            bombPlayer = nil
//            finishPlayer = nil
            decidePlayer = nil
        }

        countdownPlayer.delegate = self
        countdownPlayer.prepareToPlay()

        getpointPlayer.delegate = self
        getpointPlayer.prepareToPlay()

        bombPlayer.delegate = self
        bombPlayer.prepareToPlay()

//        finishPlayer.delegate = self
//        finishPlayer.prepareToPlay()

        decidePlayer.delegate = self
        decidePlayer.prepareToPlay()

        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }

        // 以下各座標を設定
        conveyor1.frame = CGRect(x: width * 2 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
        conveyor2.frame = CGRect(x: width * 7 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
        conveyor3.frame = CGRect(x: width * 12 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
        conveyor4.frame = CGRect(x: width * 17 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
        conveyor5.frame = CGRect(x: width * 22 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)

        pullbtn11.frame = CGRect(x: width * 2 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn12.frame = CGRect(x: width * 7 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn13.frame = CGRect(x: width * 12 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn14.frame = CGRect(x: width * 17 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn15.frame = CGRect(x: width * 22 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)

        pushbtn11.frame = CGRect(x: width * 2 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn12.frame = CGRect(x: width * 7 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn13.frame = CGRect(x: width * 12 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn14.frame = CGRect(x: width * 17 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn15.frame = CGRect(x: width * 22 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)

        pushbtn21.frame = CGRect(x: width * 2 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn22.frame = CGRect(x: width * 7 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn23.frame = CGRect(x: width * 12 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn24.frame = CGRect(x: width * 17 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pushbtn25.frame = CGRect(x: width * 22 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)

        pullbtn21.frame = CGRect(x: width * 2 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn22.frame = CGRect(x: width * 7 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn23.frame = CGRect(x: width * 12 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn24.frame = CGRect(x: width * 17 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
        pullbtn25.frame = CGRect(x: width * 22 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)

        present1.frame = CGRect(x: width * 2.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
        present2.frame = CGRect(x: width * 7.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
        present3.frame = CGRect(x: width * 12.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
        present4.frame = CGRect(x: width * 17.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
        present5.frame = CGRect(x: width * 22.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)

        pointlabel1.frame = CGRect(x: width * 11 / 28, y: height * 1.5 / 32, width: width * 6 / 28, height: height * 3 / 32)
        pointlabel2.frame = CGRect(x: width * 11 / 28, y: height * 28.5 / 32, width: width * 6 / 28, height: height * 3 / 32)

//        winloselabel1.frame = CGRect(x: width*18/28, y: height*1.5/32, width: width*6/28, height: height*3/32)
//        winloselabel2.frame = CGRect(x: width*3/28, y: height*28.5/32, width: width*6/28, height: height*3/32)

        winloselabel1.frame = CGRect(x: 0, y: height * 9 / 32, width: width, height: height * 2 / 32)
        winloselabel2.frame = CGRect(x: 0, y: height * 21 / 32, width: width, height: height * 2 / 32)

        timerlabel1.frame = CGRect(x: width * 2.5 / 28, y: height * 1.5 / 32, width: width * 3 / 28, height: width * 3 / 28)
        timerlabel2.frame = CGRect(x: width * 22.5 / 28, y: height * 29.5 / 32, width: width * 3 / 28, height: width * 3 / 28)

        calllabel.frame = CGRect(x: 0, y: height * 11 / 32, width: width, height: height * 10 / 32)

        againbtn.frame = CGRect(x: width * 9 / 28, y: height * 13 / 32, width: width * 10 / 28, height: height * 2.5 / 32)
        homebtn.frame = CGRect(x: width * 9 / 28, y: height * 16.5 / 32, width: width * 10 / 28, height: height * 2.5 / 32)

        // timerに丸枠線を設定
        timerlabel1.layer.borderWidth = 1
        timerlabel1.layer.cornerRadius = width * 1.5 / 28

        timerlabel2.layer.borderWidth = 1
        timerlabel2.layer.cornerRadius = width * 1.5 / 28
        // timerlabelに残り時間を反映
        timerlabel1.text = String(resttime)
        timerlabel2.text = String(resttime)

        againbtn.titleLabel?.adjustsFontSizeToFitWidth = true
        homebtn.titleLabel?.adjustsFontSizeToFitWidth = true

        // 画面にimageviewを貼り付け
        view.addSubview(present1)
        view.addSubview(present2)
        view.addSubview(present3)
        view.addSubview(present4)
        view.addSubview(present5)

        // player1側のlabelは反転する
        let angle1 = 90 * CGFloat.pi / 180
        transRotate1 = CGAffineTransform(rotationAngle: CGFloat(angle1))
        present1.transform = transRotate1
        present2.transform = transRotate1
        present3.transform = transRotate1
        present4.transform = transRotate1
        present5.transform = transRotate1

        // player1側のlabelは反転する
        let angle2 = CGFloat.pi
        transRotate2 = CGAffineTransform(rotationAngle: CGFloat(angle2))
        pointlabel1.transform = transRotate2
        timerlabel1.transform = transRotate2
        winloselabel1.transform = transRotate2

        // game開始
        startgame()
    }

    // game開始時の挙動
    func startgame() {
        resttime = settingtime

        // 勝ち負けlabelを非表示
        winloselabel1.isHidden = true
        winloselabel2.isHidden = true

        // timerlabelに残り時間を反映

        timerlabel1.text = String(resttime)
        timerlabel2.text = String(resttime)

        // pointを0にセット
        pointnum1 = 0
        pointnum2 = 0
        pointlabel1.text = String(pointnum1) + "pt"
        pointlabel2.text = String(pointnum2) + "pt"

        // 始まりのカウントダウン開始
        calllabel.text = "③"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.countdownPlayer.play()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.calllabel.text = "②"

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.calllabel.text = "①"

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.calllabel.isHidden = true

                        // 画面を初期化
                        self.initailstate()
                    }
                }
            }
        }
    }

    // 画面の初期状態
    func initailstate() {
        // 各presentの位置を初期位置に
        present1.frame.origin.y = height * 15 / 32
        present2.frame.origin.y = height * 15 / 32
        present3.frame.origin.y = height * 15 / 32
        present4.frame.origin.y = height * 15 / 32
        present5.frame.origin.y = height * 15 / 32

        // presentをランダムにセットして表示
        setpresent(present: present1)
        setpresent(present: present2)
        setpresent(present: present3)
        setpresent(present: present4)
        setpresent(present: present5)

        for n in 0 ..< presentviewarray.count {
            presentviewarray[n].isHidden = false
        }

        // btn有効化
        btnlinestatus(btnline: btnline1, status: true)
        btnlinestatus(btnline: btnline2, status: true)
        btnlinestatus(btnline: btnline3, status: true)
        btnlinestatus(btnline: btnline4, status: true)
        btnlinestatus(btnline: btnline5, status: true)

        // タイマーを作動
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.resttime > 0 {
                // 残り時間を減らしていく
                self.resttime -= 1
                self.timerlabel1.text = String(self.resttime)
                self.timerlabel2.text = String(self.resttime)

            } else if self.resttime == 0 {
                // タイマーを無効化にし、ゲーム終了時の挙動へ
                timer.invalidate()
                self.gamefinish()
            }
        })
    }

    // ゲーム終了時の挙動
    func gamefinish() {
//        finishPlayer.play()

        calllabel.isHidden = false
        calllabel.text = "Finish!!"

        // presentを非表示
        for n in 0 ..< presentviewarray.count {
            presentviewarray[n].isHidden = true
        }

        // btn無効化
        btnlinestatus(btnline: btnline1, status: false)
        btnlinestatus(btnline: btnline2, status: false)
        btnlinestatus(btnline: btnline3, status: false)
        btnlinestatus(btnline: btnline4, status: false)
        btnlinestatus(btnline: btnline5, status: false)

        // 結果発表
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.winloselabel1.isHidden = false
            self.winloselabel2.isHidden = false

            if self.pointnum1 > self.pointnum2 {
                self.winloselabel1.text = "Win! "
                self.winloselabel1.textColor = UIColor.red
                self.winloselabel2.text = "...Lose"
                self.winloselabel2.textColor = UIColor.blue

            } else if self.pointnum1 < self.pointnum2 {
                self.winloselabel1.text = "...Lose"
                self.winloselabel1.textColor = UIColor.blue
                self.winloselabel2.text = "Win! "
                self.winloselabel2.textColor = UIColor.red

            } else {
                self.winloselabel1.text = "Draw!"
                self.winloselabel1.textColor = UIColor.black
                self.winloselabel2.text = "Draw!"
                self.winloselabel2.textColor = UIColor.black
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.calllabel.isHidden = true

            self.againbtn.isHidden = false
            self.homebtn.isHidden = false

            // 無効化漏れに備えて再度無効化
            self.btnlinestatus(btnline: self.btnline1, status: false)
            self.btnlinestatus(btnline: self.btnline2, status: false)
            self.btnlinestatus(btnline: self.btnline3, status: false)
            self.btnlinestatus(btnline: self.btnline4, status: false)
            self.btnlinestatus(btnline: self.btnline5, status: false)
        }
    }

    @IBAction func startagain(_: Any) {
        startgame()
        againbtn.isHidden = true
        homebtn.isHidden = true
        calllabel.isHidden = false
    }

    @IBAction func movepresent1(_ sender: Any) {
        // 上向矢印はtagを1として、presentを上へ
        if ((sender as AnyObject).tag)! == 1 {
            presentup(present: present1)

            // 下向矢印はtagを2として、presentを上へ
        } else if ((sender as AnyObject).tag)! == 2 {
            presentdown(present: present1)
        }

        // どちらの得点か判定
        whosepresent(present: present1, btnline: btnline1)
    }

    @IBAction func movepresent2(_ sender: Any) {
        if ((sender as AnyObject).tag)! == 1 {
            presentup(present: present2)

        } else if ((sender as AnyObject).tag)! == 2 {
            presentdown(present: present2)
        }

        whosepresent(present: present2, btnline: btnline2)
    }

    @IBAction func movepresent3(_ sender: Any) {
        if ((sender as AnyObject).tag)! == 1 {
            presentup(present: present3)

        } else if ((sender as AnyObject).tag)! == 2 {
            presentdown(present: present3)
        }

        whosepresent(present: present3, btnline: btnline3)
    }

    @IBAction func movepresent4(_ sender: Any) {
        if ((sender as AnyObject).tag)! == 1 {
            presentup(present: present4)

        } else if ((sender as AnyObject).tag)! == 2 {
            presentdown(present: present4)
        }

        whosepresent(present: present4, btnline: btnline4)
    }

    @IBAction func movepresent5(_ sender: Any) {
        if ((sender as AnyObject).tag)! == 1 {
            presentup(present: present5)

        } else if ((sender as AnyObject).tag)! == 2 {
            presentdown(present: present5)
        }

        whosepresent(present: present5, btnline: btnline5)
    }

    func presentup(present: UIImageView) {
        present.frame.origin.y -= height * 1 / 32
    }

    func presentdown(present: UIImageView) {
        present.frame.origin.y += height * 1 / 32
    }

    // どちらの得点か判定
    func whosepresent(present: UIImageView, btnline: [UIButton]) {
        // 得点の数字を入れる箱を用意
        var getpoint = 0

        // presentによって得点が異なる
        switch present.image?.accessibilityIdentifier {
        case "apple":
            getpoint = 10

        case "grape":
            getpoint = 20

        case "melon":
            getpoint = 30

        case "peach":
            getpoint = 40

        case "banana":
            getpoint = 50

        case "cherry":
            getpoint = 60

        case "diamond":
            getpoint = 100

        case "bomb":
            getpoint = -50

        default:
            break
        }

        // presentがplayer1側に届いた時
        if present.frame.origin.y < height * 10 / 32 {
            if getpoint == -50 {
                bombPlayer.play()
            } else {
                getpointPlayer.play()
            }
            // 一旦btn無効化
            btnlinestatus(btnline: btnline, status: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.pointnum1 += getpoint

                self.pointlabel1.text = String(self.pointnum1) + "pt"

                // presentのviewを初期位置に、新しいpresentをランダムにセット
                present.frame.origin.y = self.height * 15 / 32
                self.setpresent(present: present)

                // btn有効化
                self.btnlinestatus(btnline: btnline, status: true)
            }
        }

        // presentがplayer2側に届いた時
        if present.frame.origin.y > height * 20 / 32 {
            if getpoint == -50 {
                bombPlayer.play()
            } else {
                getpointPlayer.play()
            }

            btnlinestatus(btnline: btnline, status: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.pointnum2 += getpoint

                self.pointlabel2.text = String(self.pointnum2) + "pt"

                present.frame.origin.y = self.height * 15 / 32

                self.btnlinestatus(btnline: btnline, status: true)

                self.setpresent(present: present)
            }
        }
    }

    // presentをランダムにセット
    func setpresent(present: UIImageView) {
        let n = Int.random(in: 1 ... presentarray.count)
        let nextpresent = presentarray[n - 1]
        present.image = UIImage(named: nextpresent)
        present.image?.accessibilityIdentifier = nextpresent
    }

    // btnlineの有効化/無効化を管理
    func btnlinestatus(btnline: [UIButton], status: Bool) {
        for n in 0 ..< btnline.count {
            btnline[n].isEnabled = status
        }
    }

    @IBAction func makesoundbtn(_: Any) {
        decidePlayer.play()
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "tostartscreen" {
            let startscreen = segue.destination as! Startscreen
            startscreen.settingtime = settingtime
        }
    }
}

extension UIImageView {
    func getFileName() -> String? {
        return image?.accessibilityIdentifier
    }
}
