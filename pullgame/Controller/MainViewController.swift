//
//  ViewController.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/08/22.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit



class MainViewController: UIViewController, AVAudioPlayerDelegate, BtnAction{
    
    var sounds = Sounds()
    var presentLocation = PresentLocation()
    
    @IBOutlet var conveyor1: UIImageView!
    @IBOutlet var conveyor2: UIImageView!
    @IBOutlet var conveyor3: UIImageView!
    @IBOutlet var conveyor4: UIImageView!
    @IBOutlet var conveyor5: UIImageView!

    @IBOutlet var callLabel: UILabel!

    @IBOutlet var againBtn: UIButton!
    @IBOutlet var homeBtn: UIButton!
    
    
    @IBOutlet weak var consoleView1: CustomView!
    @IBOutlet weak var consoleView2: CustomView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!
    @IBOutlet weak var imageView11: UIImageView!
    @IBOutlet weak var imageView12: UIImageView!
    @IBOutlet weak var imageView13: UIImageView!
    @IBOutlet weak var imageView14: UIImageView!
    @IBOutlet weak var imageView15: UIImageView!
    @IBOutlet weak var imageView16: UIImageView!
    @IBOutlet weak var imageView17: UIImageView!
    @IBOutlet weak var imageView18: UIImageView!
    @IBOutlet weak var imageView19: UIImageView!
    @IBOutlet weak var imageView20: UIImageView!
    @IBOutlet weak var imageView21: UIImageView!
    @IBOutlet weak var imageView22: UIImageView!
    @IBOutlet weak var imageView23: UIImageView!
    @IBOutlet weak var imageView24: UIImageView!
    @IBOutlet weak var imageView25: UIImageView!
    @IBOutlet weak var imageView26: UIImageView!
    @IBOutlet weak var imageView27: UIImageView!
    @IBOutlet weak var imageView28: UIImageView!
    @IBOutlet weak var imageView29: UIImageView!
    @IBOutlet weak var imageView30: UIImageView!
    @IBOutlet weak var imageView31: UIImageView!
    @IBOutlet weak var imageView32: UIImageView!
    @IBOutlet weak var imageView33: UIImageView!
    @IBOutlet weak var imageView34: UIImageView!
    @IBOutlet weak var imageView35: UIImageView!
   
    var pointNum1 = 0
    var pointNum2 = 0

    var timer = Timer()
    var settingTime = 0
    var restTime = 0
    
    // btnを1列ごとに管理
    var btnLine1: [UIButton] = []
    var btnLine2: [UIButton] = []
    var btnLine3: [UIButton] = []
    var btnLine4: [UIButton] = []
    var btnLine5: [UIButton] = []
    
    // btnLineを一括管理
    var btnLineArray : [[UIButton]] = []

    // present名を管理
    var presentNameAndPoint = [String:Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Btnを一列毎に管理
        btnLine1 = [consoleView1.upBtn0,consoleView1.downBtn0,consoleView2.upBtn0,consoleView2.downBtn0]
        btnLine2 = [consoleView1.upBtn1,consoleView1.downBtn1,consoleView2.upBtn1,consoleView2.downBtn1]
        btnLine3 = [consoleView1.upBtn2,consoleView1.downBtn2,consoleView2.upBtn2,consoleView2.downBtn2]
        btnLine4 = [consoleView1.upBtn3,consoleView1.downBtn3,consoleView2.upBtn3,consoleView2.downBtn3]
        btnLine5 = [consoleView1.upBtn4,consoleView1.downBtn4,consoleView2.upBtn4,consoleView2.downBtn4]
        
        //btnLineを一括管理
        btnLineArray = [btnLine1, btnLine2, btnLine3, btnLine4, btnLine5]

        presentNameAndPoint = ["apple":10, "grape":20, "melon":30, "peach":40, "banana":50, "cherry":60, "diamond":100, "bomb":-50]

        // timerに枠線を設定
        consoleView1.timerLabel.layer.borderWidth = 1
        consoleView2.timerLabel.layer.borderWidth = 1
        
        againBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        homeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

        // player1側のLabelは180度回転させる
        rotate(consoleView1, 180)
        //ボタンだけは元に戻す
        rotate(consoleView1.BtnSV, 180)
        
        // timerLabelに残り時間を反映
        loadTime(settingTime)

        // game開始
        gameStart()
        
    }
    
    // Viewを回転させる
    func rotate(_ UIView: UIView, _ angle: CGFloat){
        
        let oneDegree = CGFloat.pi/180
        UIView.transform = CGAffineTransform(rotationAngle: CGFloat(oneDegree*angle))
        
    }
    
    // game開始時の挙動
    func gameStart() {
        
        // 画面を初期化
        beforeCountDown()

        // 始まりのカウントダウン開始
        callLabel.text = "③"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sounds.playSound(fileName: "countDown", extentionName: "mp3")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.callLabel.text = "②"

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.callLabel.text = "①"

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.afterCountDown()
                    }
                }
            }
        }
    }

    // カウントダウン開始時の状態
    func beforeCountDown() {
        
        //各種表示/非表示切り替え
        againBtn.isHidden = true
        homeBtn.isHidden = true
        callLabel.isHidden = false
        
        //presentのロジックを初期状態にセット
        for y in 0..<presentLocation.state[3].count {
            presentLocation.state[3][y] = RondomPresent()
        }
        
        // 勝ち負けLabelを非表示
       consoleView1.winOrLoseLabel.isHidden = true
       consoleView2.winOrLoseLabel.isHidden = true
        
       // pointを0にセット
       pointNum1 = 0
       pointNum2 = 0
       consoleView1.pointLabel.text = "\(pointNum2)pt"
       consoleView2.pointLabel.text = "\(pointNum2)pt"
    }
    
    func RondomPresent() -> String{
        let presentNameArray = Array(presentNameAndPoint.keys)
        let n = Int.random(in: 1 ... presentNameArray.count)
        let newPresent = presentNameArray[n-1]
        return newPresent
    }
    
    // カウントダウン開始後の状態。
    func afterCountDown() {
        
        callLabel.isHidden = true
        
        loadState()
        
        //タイマースタート
        timerStart()
            
        // Btn有効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: true)
        }
    }
    
    // presentの位置情報を読み込む
    func loadState(){
        imageView1.image = UIImage(named: presentLocation.state[0][0])
        imageView2.image = UIImage(named: presentLocation.state[0][1])
        imageView3.image = UIImage(named: presentLocation.state[0][2])
        imageView4.image = UIImage(named: presentLocation.state[0][3])
        imageView5.image = UIImage(named: presentLocation.state[0][4])
        imageView6.image = UIImage(named: presentLocation.state[1][0])
        imageView7.image = UIImage(named: presentLocation.state[1][1])
        imageView8.image = UIImage(named: presentLocation.state[1][2])
        imageView9.image = UIImage(named: presentLocation.state[1][3])
        imageView10.image = UIImage(named: presentLocation.state[1][4])
        imageView11.image = UIImage(named: presentLocation.state[2][0])
        imageView12.image = UIImage(named: presentLocation.state[2][1])
        imageView13.image = UIImage(named: presentLocation.state[2][2])
        imageView14.image = UIImage(named: presentLocation.state[2][3])
        imageView15.image = UIImage(named: presentLocation.state[2][4])
        imageView16.image = UIImage(named: presentLocation.state[3][0])
        imageView17.image = UIImage(named: presentLocation.state[3][1])
        imageView18.image = UIImage(named: presentLocation.state[3][2])
        imageView19.image = UIImage(named: presentLocation.state[3][3])
        imageView20.image = UIImage(named: presentLocation.state[3][4])
        imageView21.image = UIImage(named: presentLocation.state[4][0])
        imageView22.image = UIImage(named: presentLocation.state[4][1])
        imageView23.image = UIImage(named: presentLocation.state[4][2])
        imageView24.image = UIImage(named: presentLocation.state[4][3])
        imageView25.image = UIImage(named: presentLocation.state[4][4])
        imageView26.image = UIImage(named: presentLocation.state[5][0])
        imageView27.image = UIImage(named: presentLocation.state[5][1])
        imageView28.image = UIImage(named: presentLocation.state[5][2])
        imageView29.image = UIImage(named: presentLocation.state[5][3])
        imageView30.image = UIImage(named: presentLocation.state[5][4])
        imageView31.image = UIImage(named: presentLocation.state[6][0])
        imageView32.image = UIImage(named: presentLocation.state[6][1])
        imageView33.image = UIImage(named: presentLocation.state[6][2])
        imageView34.image = UIImage(named: presentLocation.state[6][3])
        imageView35.image = UIImage(named: presentLocation.state[6][4])
    }

    func timerStart(){
        
        restTime = settingTime
        loadTime(restTime)
        
        // タイマーを作動
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            if self.restTime > 0 {
                // 残り時間を減らしていく
                self.restTime -= 1
                self.loadTime(self.restTime)
                
            }
            if self.restTime == 0 {
                // タイマーを無効化にし、ゲーム終了時の挙動へ
                timer.invalidate()
                self.gameFinish()
            }
        })
    }
    
    func loadTime(_ Time: Int){
        consoleView1.timerLabel.text = "\(Time)"
        consoleView2.timerLabel.text = "\(Time)"
    }

    // ゲーム終了時の挙動
    func gameFinish() {
        
        sounds.playSound(fileName: "finish", extentionName: "mp3")
        
        //画面上からpresentを消す
        presentLocation.state = presentLocation.getEmptyState()
        loadState()
    
        callLabel.isHidden = false
        callLabel.text = "Finish!!"

        // Btn無効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: false)
        }
        

        // 結果発表
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.comparePoint()
            
            //時間差で表示されることがあるため、もう一度
            //画面上からpresentを消す
            self.presentLocation.state = self.presentLocation.getEmptyState()
            self.loadState()
            // Btn無効化
            for btnLine in self.btnLineArray {
                self.btnLineStatus(btnLine: btnLine, status: false)
            }
        }

        //メニュー表示
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.callLabel.isHidden = true
            self.againBtn.isHidden = false
            self.homeBtn.isHidden = false
        }
    }
    
    //点数比較して勝ち負けを表示
    func comparePoint(){
        
        consoleView1.winOrLoseLabel.isHidden = false
        consoleView2.winOrLoseLabel.isHidden = false
   
        if pointNum1 > pointNum2 {
           
           consoleView1.winOrLoseLabel.text = "Win! "
           consoleView1.winOrLoseLabel.textColor = UIColor.red
           consoleView2.winOrLoseLabel.text = "...Lose"
           consoleView2.winOrLoseLabel.textColor = UIColor.blue
           
       } else if pointNum1 < pointNum2 {

           consoleView1.winOrLoseLabel.text = "...Lose"
           consoleView1.winOrLoseLabel.textColor = UIColor.blue
           consoleView2.winOrLoseLabel.text = "Win! "
           consoleView2.winOrLoseLabel.textColor = UIColor.red
           
       } else {

           consoleView1.winOrLoseLabel.text = "Draw!"
           consoleView1.winOrLoseLabel.textColor = UIColor.black
           consoleView2.winOrLoseLabel.text = "Draw!"
           consoleView2.winOrLoseLabel.textColor = UIColor.black
        }
 
    }
    
    
    //delegateメソッド
    func didTapUp(_ tag: Int) {
        
        //presentの位置を把握
        var location = presentLocation.findLocation(tag: tag)
        
        //何のpresentか把握
        let presentName = presentLocation.state[location.x][location.y]
        
        //一旦その位置からpresentを削除
        presentLocation.state[location.x][location.y] = ""
        
        //表示位置を変更
        switch location.x {
        case 1:
            location.x = 0
        case 2:
            location.x = 1
        case 3:
            location.x = 2
        case 4:
            location.x = 3
        case 5:
            location.x = 4
        case 6:
            location.x = 5
        default:
            break
        }
        
        //変更した表示位置に同じpresentを表示
        presentLocation.state[location.x][location.y] = presentName
        loadState()
        
        //player1側にpresentが到着した時
        if location.x == 0{

            //そのプレゼントの得点を取得
            let getPoint = presentNameAndPoint[presentName] ?? 0
            
            //得点によって音声を再生
            playSoundByTypeOfPresent(getPoint)
            
            pointNum1 += getPoint
            
            consoleView1.pointLabel.text = "\(pointNum1)pt"
            
            //その列のボタンを一旦無効化
            btnLineStatus(btnLine: btnLineArray[tag], status: false)
            
            //残り時間があれば0.25秒後のランダムなpresentを初期位置にセット
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.restTime > 0 {
                    self.resetPresent(location: location)
                    //ボタンを有効化
                    self.btnLineStatus(btnLine: self.btnLineArray[tag], status: true)
                }
            }
        }
    }
    
    //delegateメソッド
    func didTapDown(_ tag: Int) {
        
        //presentの位置を把握
        var location = presentLocation.findLocation(tag: tag)
        
        //何のpresentか把握
        let presentName = presentLocation.state[location.x][location.y]
        
        //一旦その位置からpresentを削除
        presentLocation.state[location.x][location.y] = ""
        
        //表示位置を変更
        switch location.x {
        case 0:
            location.x = 1
        case 1:
            location.x = 2
        case 2:
            location.x = 3
        case 3:
            location.x = 4
        case 4:
            location.x = 5
        case 5:
            location.x = 6
        default:
            break
        }
        
        //変更した表示位置に同じpresentを表示
        presentLocation.state[location.x][location.y] = presentName
        loadState()
        
        //player2側にpresentが到着した時
        if location.x == 6{
            
            //そのプレゼントの得点を取得
            let getPoint = presentNameAndPoint[presentName] ?? 0
            
            //得点によって音声を再生
            playSoundByTypeOfPresent(getPoint)
            
            pointNum2 += getPoint
            
            consoleView2.pointLabel.text = "\(pointNum2)pt"
            
            //その列のボタンを一旦無効化
            btnLineStatus(btnLine: btnLineArray[tag], status: false)
            
            //残り時間があれば0.25秒後のランダムなpresentを初期位置にセット
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.restTime > 0 {
                    self.resetPresent(location: location)
                    //ボタンを有効化
                    self.btnLineStatus(btnLine: self.btnLineArray[tag], status: true)
                }
            }
        }
    }
    
    func resetPresent(location: Location){
        presentLocation.state[location.x][location.y] = ""
        presentLocation.state[3][location.y] = RondomPresent()
        loadState()
    }
    
    @IBAction func startAgain(_: Any) {
        gameStart()
        sounds.playSound(fileName: "decide", extentionName: "mp3")
    }

    //presentの種類によって音声を再生
    func playSoundByTypeOfPresent(_ getpoint: Int){
        //presentが爆弾なら爆発音、それ以外なら得点
        if getpoint == presentNameAndPoint["bomb"] {
            sounds.playSound(fileName: "bomb", extentionName: "mp3")
        } else {
            sounds.playSound(fileName: "getPoint", extentionName: "mp3")
           }
    }

    // 1列毎のbtnLineの有効化/無効化を管理
    func btnLineStatus(btnLine: [UIButton], status: Bool) {
        for btn in btnLine {
            btn.isEnabled = status
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toStart" {
            sounds.playSound(fileName: "decide", extentionName: "mp3")
            let startVC = segue.destination as! StartViewController
            startVC.settingTime = settingTime
        }
    }
}
