//
//  ViewController.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/08/22.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit

class MainViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var conveyor1: UIImageView!
    @IBOutlet var conveyor2: UIImageView!
    @IBOutlet var conveyor3: UIImageView!
    @IBOutlet var conveyor4: UIImageView!
    @IBOutlet var conveyor5: UIImageView!

    @IBOutlet var pullBtn11: UIButton!
    @IBOutlet var pullBtn12: UIButton!
    @IBOutlet var pullBtn13: UIButton!
    @IBOutlet var pullBtn14: UIButton!
    @IBOutlet var pullBtn15: UIButton!

    @IBOutlet var pushBtn11: UIButton!
    @IBOutlet var pushBtn12: UIButton!
    @IBOutlet var pushBtn13: UIButton!
    @IBOutlet var pushBtn14: UIButton!
    @IBOutlet var pushBtn15: UIButton!

    @IBOutlet var pullBtn21: UIButton!
    @IBOutlet var pullBtn22: UIButton!
    @IBOutlet var pullBtn23: UIButton!
    @IBOutlet var pullBtn24: UIButton!
    @IBOutlet var pullBtn25: UIButton!

    @IBOutlet var pushBtn21: UIButton!
    @IBOutlet var pushBtn22: UIButton!
    @IBOutlet var pushBtn23: UIButton!
    @IBOutlet var pushBtn24: UIButton!
    @IBOutlet var pushBtn25: UIButton!

    @IBOutlet var pointLabel1: UILabel!
    @IBOutlet var pointLabel2: UILabel!

    @IBOutlet var timerLabel1: UILabel!
    @IBOutlet var timerLabel2: UILabel!

    @IBOutlet var winLoseLabel1: UILabel!
    @IBOutlet var winLoseLabel2: UILabel!

    @IBOutlet var callLabel: UILabel!

    @IBOutlet var againBtn: UIButton!
    @IBOutlet var homeBtn: UIButton!
    
    var sounds = Sounds()

    var present1 = UIImageView()
    var present2 = UIImageView()
    var present3 = UIImageView()
    var present4 = UIImageView()
    var present5 = UIImageView()

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    var pointNum1 = 0
    var pointNum2 = 0

    var settingTime = 0
    var restTime = 0

    var timer = Timer()

    var transRotate1 = CGAffineTransform()
    var transRotate2 = CGAffineTransform()

    // btnを1列ごとに管理
    var btnLine1: [UIButton] = []
    var btnLine2: [UIButton] = []
    var btnLine3: [UIButton] = []
    var btnLine4: [UIButton] = []
    var btnLine5: [UIButton] = []

    // present名を管理
    var presentArray: [String] = []

    var presentViewArray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        btnLine1 = [pullBtn11, pushBtn11, pushBtn21, pullBtn21]
                btnLine2 = [pullBtn12, pushBtn12, pushBtn22, pullBtn22]
                btnLine3 = [pullBtn13, pushBtn13, pushBtn23, pullBtn23]
                btnLine4 = [pullBtn14, pushBtn14, pushBtn24, pullBtn24]
                btnLine5 = [pullBtn15, pushBtn15, pushBtn25, pullBtn25]

                presentViewArray = [present1, present2, present3, present4, present5]

                presentArray = ["apple", "grape", "melon", "peach", "banana", "cherry", "diamond", "bomb", "bomb"]

                // 以下各座標を設定
                conveyor1.frame = CGRect(x: width * 2 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
                conveyor2.frame = CGRect(x: width * 7 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
                conveyor3.frame = CGRect(x: width * 12 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
                conveyor4.frame = CGRect(x: width * 17 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)
                conveyor5.frame = CGRect(x: width * 22 / 28, y: height * 11 / 32, width: width * 4 / 28, height: height * 10 / 32)

                pullBtn11.frame = CGRect(x: width * 2 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn12.frame = CGRect(x: width * 7 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn13.frame = CGRect(x: width * 12 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn14.frame = CGRect(x: width * 17 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn15.frame = CGRect(x: width * 22 / 28, y: height * 4.5 / 32, width: width * 4 / 28, height: height * 2 / 32)

                pushBtn11.frame = CGRect(x: width * 2 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn12.frame = CGRect(x: width * 7 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn13.frame = CGRect(x: width * 12 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn14.frame = CGRect(x: width * 17 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn15.frame = CGRect(x: width * 22 / 28, y: height * 7 / 32, width: width * 4 / 28, height: height * 2 / 32)

                pushBtn21.frame = CGRect(x: width * 2 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn22.frame = CGRect(x: width * 7 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn23.frame = CGRect(x: width * 12 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn24.frame = CGRect(x: width * 17 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pushBtn25.frame = CGRect(x: width * 22 / 28, y: height * 23 / 32, width: width * 4 / 28, height: height * 2 / 32)

                pullBtn21.frame = CGRect(x: width * 2 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn22.frame = CGRect(x: width * 7 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn23.frame = CGRect(x: width * 12 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn24.frame = CGRect(x: width * 17 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)
                pullBtn25.frame = CGRect(x: width * 22 / 28, y: height * 25.5 / 32, width: width * 4 / 28, height: height * 2 / 32)

                present1.frame = CGRect(x: width * 2.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
                present2.frame = CGRect(x: width * 7.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
                present3.frame = CGRect(x: width * 12.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
                present4.frame = CGRect(x: width * 17.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)
                present5.frame = CGRect(x: width * 22.5 / 28, y: height * 15 / 32, width: width * 3 / 28, height: height * 2 / 32)

                pointLabel1.frame = CGRect(x: width * 11 / 28, y: height * 1.5 / 32, width: width * 6 / 28, height: height * 3 / 32)
                pointLabel2.frame = CGRect(x: width * 11 / 28, y: height * 28.5 / 32, width: width * 6 / 28, height: height * 3 / 32)

                winLoseLabel1.frame = CGRect(x: 0, y: height * 9 / 32, width: width, height: height * 2 / 32)
                winLoseLabel2.frame = CGRect(x: 0, y: height * 21 / 32, width: width, height: height * 2 / 32)

                timerLabel1.frame = CGRect(x: width * 2.5 / 28, y: height * 1.5 / 32, width: width * 3 / 28, height: width * 3 / 28)
                timerLabel2.frame = CGRect(x: width * 22.5 / 28, y: height * 29.5 / 32, width: width * 3 / 28, height: width * 3 / 28)

                callLabel.frame = CGRect(x: 0, y: height * 11 / 32, width: width, height: height * 10 / 32)

                againBtn.frame = CGRect(x: width * 9 / 28, y: height * 13 / 32, width: width * 10 / 28, height: height * 2.5 / 32)
                homeBtn.frame = CGRect(x: width * 9 / 28, y: height * 16.5 / 32, width: width * 10 / 28, height: height * 2.5 / 32)

                // timerに丸枠線を設定
                timerLabel1.layer.borderWidth = 1
                timerLabel1.layer.cornerRadius = width * 1.5 / 28

                timerLabel2.layer.borderWidth = 1
                timerLabel2.layer.cornerRadius = width * 1.5 / 28
                // timerLabelに残り時間を反映
                timerLabel1.text = String(restTime)
                timerLabel2.text = String(restTime)

                againBtn.titleLabel?.adjustsFontSizeToFitWidth = true
                homeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

                // 画面にimageviewを貼り付け
                view.addSubview(present1)
                view.addSubview(present2)
                view.addSubview(present3)
                view.addSubview(present4)
                view.addSubview(present5)

                // player1側のLabelは反転する
                let angle1 = 90 * CGFloat.pi / 180
                transRotate1 = CGAffineTransform(rotationAngle: CGFloat(angle1))
                present1.transform = transRotate1
                present2.transform = transRotate1
                present3.transform = transRotate1
                present4.transform = transRotate1
                present5.transform = transRotate1

                // player1側のLabelは反転する
                let angle2 = CGFloat.pi
                transRotate2 = CGAffineTransform(rotationAngle: CGFloat(angle2))
                pointLabel1.transform = transRotate2
                timerLabel1.transform = transRotate2
                winLoseLabel1.transform = transRotate2

                // game開始
                startGame()
            }

            // game開始時の挙動
            func startGame() {
                restTime = settingTime

                // 勝ち負けLabelを非表示
                winLoseLabel1.isHidden = true
                winLoseLabel2.isHidden = true

                // timerLabelに残り時間を反映

                timerLabel1.text = String(restTime)
                timerLabel2.text = String(restTime)

                // pointを0にセット
                pointNum1 = 0
                pointNum2 = 0
                pointLabel1.text = String(pointNum1) + "pt"
                pointLabel2.text = String(pointNum2) + "pt"

                // 始まりのカウントダウン開始
                callLabel.text = "③"

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.sounds.playSound(fileName: "countDown", extentionName:  "mp3")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.callLabel.text = "②"

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.callLabel.text = "①"

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.callLabel.isHidden = true

                                // 画面を初期化
                                self.initailState()
                            }
                        }
                    }
                }
            }

            // 画面の初期状態
            func initailState() {
                // 各presentの位置を初期位置に
                present1.frame.origin.y = height * 15 / 32
                present2.frame.origin.y = height * 15 / 32
                present3.frame.origin.y = height * 15 / 32
                present4.frame.origin.y = height * 15 / 32
                present5.frame.origin.y = height * 15 / 32

                // presentをランダムにセットして表示
                setPresent(present: present1)
                setPresent(present: present2)
                setPresent(present: present3)
                setPresent(present: present4)
                setPresent(present: present5)

                for n in 0 ..< presentViewArray.count {
                    presentViewArray[n].isHidden = false
                }

                // Btn有効化
                btnLineStatus(btnLine: btnLine1, status: true)
                btnLineStatus(btnLine: btnLine2, status: true)
                btnLineStatus(btnLine: btnLine3, status: true)
                btnLineStatus(btnLine: btnLine4, status: true)
                btnLineStatus(btnLine: btnLine5, status: true)

                // タイマーを作動
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                    if self.restTime > 0 {
                        // 残り時間を減らしていく
                        self.restTime -= 1
                        self.timerLabel1.text = String(self.restTime)
                        self.timerLabel2.text = String(self.restTime)

                    } else if self.restTime == 0 {
                        // タイマーを無効化にし、ゲーム終了時の挙動へ
                        timer.invalidate()
                        self.gameFinish()
                    }
                })
            }

            // ゲーム終了時の挙動
            func gameFinish() {
                sounds.playSound(fileName: "finish", extentionName: "mp3")

                callLabel.isHidden = false
                callLabel.text = "Finish!!"

                // presentを非表示
                for n in 0 ..< presentViewArray.count {
                    presentViewArray[n].isHidden = true
                }

                // Btn無効化
                btnLineStatus(btnLine: btnLine1, status: false)
                btnLineStatus(btnLine: btnLine2, status: false)
                btnLineStatus(btnLine: btnLine3, status: false)
                btnLineStatus(btnLine: btnLine4, status: false)
                btnLineStatus(btnLine: btnLine5, status: false)

                // 結果発表
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.winLoseLabel1.isHidden = false
                    self.winLoseLabel2.isHidden = false

                    if self.pointNum1 > self.pointNum2 {
                        self.winLoseLabel1.text = "Win! "
                        self.winLoseLabel1.textColor = UIColor.red
                        self.winLoseLabel2.text = "...Lose"
                        self.winLoseLabel2.textColor = UIColor.blue

                    } else if self.pointNum1 < self.pointNum2 {
                        self.winLoseLabel1.text = "...Lose"
                        self.winLoseLabel1.textColor = UIColor.blue
                        self.winLoseLabel2.text = "Win! "
                        self.winLoseLabel2.textColor = UIColor.red

                    } else {
                        self.winLoseLabel1.text = "Draw!"
                        self.winLoseLabel1.textColor = UIColor.black
                        self.winLoseLabel2.text = "Draw!"
                        self.winLoseLabel2.textColor = UIColor.black
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.callLabel.isHidden = true

                    self.againBtn.isHidden = false
                    self.homeBtn.isHidden = false

                    // 無効化漏れに備えて再度無効化
                    self.btnLineStatus(btnLine: self.btnLine1, status: false)
                    self.btnLineStatus(btnLine: self.btnLine2, status: false)
                    self.btnLineStatus(btnLine: self.btnLine3, status: false)
                    self.btnLineStatus(btnLine: self.btnLine4, status: false)
                    self.btnLineStatus(btnLine: self.btnLine5, status: false)
                }
            }

            @IBAction func startAgain(_: Any) {
                startGame()
                playDecideSound()
                againBtn.isHidden = true
                homeBtn.isHidden = true
                callLabel.isHidden = false
            }

            @IBAction func movePresent1(_ sender: Any) {
                // 上向矢印はtagを1として、presentを上へ
                if ((sender as AnyObject).tag)! == 1 {
                    presentUp(present: present1)

                    // 下向矢印はtagを2として、presentを上へ
                } else if ((sender as AnyObject).tag)! == 2 {
                    presentDown(present: present1)
                }

                // どちらの得点か判定
                whosePresent(present: present1, btnLine: btnLine1)
            }

            @IBAction func movePresent2(_ sender: Any) {
                if ((sender as AnyObject).tag)! == 1 {
                    presentUp(present: present2)

                } else if ((sender as AnyObject).tag)! == 2 {
                    presentDown(present: present2)
                }

                whosePresent(present: present2, btnLine: btnLine2)
            }

            @IBAction func movePresent3(_ sender: Any) {
                if ((sender as AnyObject).tag)! == 1 {
                    presentUp(present: present3)

                } else if ((sender as AnyObject).tag)! == 2 {
                    presentDown(present: present3)
                }

                whosePresent(present: present3, btnLine: btnLine3)
            }

            @IBAction func movePresent4(_ sender: Any) {
                if ((sender as AnyObject).tag)! == 1 {
                    presentUp(present: present4)

                } else if ((sender as AnyObject).tag)! == 2 {
                    presentDown(present: present4)
                }

                whosePresent(present: present4, btnLine: btnLine4)
            }

            @IBAction func movePresent5(_ sender: Any) {
                if ((sender as AnyObject).tag)! == 1 {
                    presentUp(present: present5)

                } else if ((sender as AnyObject).tag)! == 2 {
                    presentDown(present: present5)
                }

                whosePresent(present: present5, btnLine: btnLine5)
            }

            func presentUp(present: UIImageView) {
                present.frame.origin.y -= height * 1 / 32
            }

            func presentDown(present: UIImageView) {
                present.frame.origin.y += height * 1 / 32
            }

            // どちらの得点か判定
            func whosePresent(present: UIImageView, btnLine: [UIButton]) {
                // 得点の数字を入れる箱を用意
                var getPoint = 0

                // presentによって得点が異なる
                switch present.image?.accessibilityIdentifier {
                case "apple":
                    getPoint = 10

                case "grape":
                    getPoint = 20

                case "melon":
                    getPoint = 30

                case "peach":
                    getPoint = 40

                case "banana":
                    getPoint = 50

                case "cherry":
                    getPoint = 60

                case "diamond":
                    getPoint = 100

                case "bomb":
                    getPoint = -50

                default:
                    break
                }

                // presentがplayer1側に届いた時
                if present.frame.origin.y < height * 10 / 32 {
                    if getPoint == -50 {
                        sounds.playSound(fileName: "bomb", extentionName: "mp3")
                    } else {
                        sounds.playSound(fileName: "getPoint", extentionName: "mp3")
                    }
                    // 一旦Btn無効化
                    btnLineStatus(btnLine: btnLine, status: false)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.pointNum1 += getPoint

                        self.pointLabel1.text = String(self.pointNum1) + "pt"

                        // presentのviewを初期位置に、新しいpresentをランダムにセット
                        present.frame.origin.y = self.height * 15 / 32
                        self.setPresent(present: present)

                        // Btn有効化
                        self.btnLineStatus(btnLine: btnLine, status: true)
                    }
                }

                // presentがplayer2側に届いた時
                if present.frame.origin.y > height * 20 / 32 {
                    if getPoint == -50 {
                        sounds.playSound(fileName: "bomb", extentionName: "mp3")
                    } else {
                        sounds.playSound(fileName: "getPoint", extentionName: "mp3")
                    }

                    btnLineStatus(btnLine: btnLine, status: false)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.pointNum2 += getPoint

                        self.pointLabel2.text = String(self.pointNum2) + "pt"

                        present.frame.origin.y = self.height * 15 / 32

                        self.btnLineStatus(btnLine: btnLine, status: true)

                        self.setPresent(present: present)
                    }
                }
            }

            // presentをランダムにセット
            func setPresent(present: UIImageView) {
                let n = Int.random(in: 1 ... presentArray.count)
                let nextPresent = presentArray[n - 1]
                present.image = UIImage(named: nextPresent)
                present.image?.accessibilityIdentifier = nextPresent
            }

            // btnLineの有効化/無効化を管理
            func btnLineStatus(btnLine: [UIButton], status: Bool) {
                for n in 0 ..< btnLine.count {
                    btnLine[n].isEnabled = status
                }
            }

    
    func playDecideSound(){
        sounds.playSound(fileName: "decide", extentionName: "mp3")
    }

            override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
                if segue.identifier == "toStart" {
                    playDecideSound()
                    let startVC = segue.destination as! StartViewController
                    startVC.settingTime = settingTime
                }
            }
        }

extension UIImageView {
    func getFileName() -> String? {
        return image?.accessibilityIdentifier
    }
}
