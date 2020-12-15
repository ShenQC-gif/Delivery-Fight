//
//  ViewController.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/08/22.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit

struct Location {
    var x : Int
    var y : Int
}

class MainViewController: UIViewController, AVAudioPlayerDelegate, BtnAction{
    
    
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

    
    var sounds = Sounds()

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
   
    var pointNum1 = 0
    var pointNum2 = 0

    var settingTime = 0
    var restTime = 0

    var timer = Timer()

    
    // btnを1列ごとに管理
    var btnLine1: [UIButton] = []
    var btnLine2: [UIButton] = []
    var btnLine3: [UIButton] = []
    var btnLine4: [UIButton] = []
    var btnLine5: [UIButton] = []
    
    var gameState = [
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
    ]
    
    // btnLineを一括管理
    var btnLineArray : [[UIButton]] = []

    // present名を管理
    var presentNameAndPoint = [String:Int]()
    
    var presentViewArray: [UIImageView] = []

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

        // timerに丸枠線を設定
        consoleView1.timerLabel.layer.borderWidth = 1
        consoleView2.timerLabel.layer.borderWidth = 1

        // timerLabelに残り時間を反映
        consoleView1.timerLabel.text = String(restTime)
        consoleView2.timerLabel.text = String(restTime)

        againBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        homeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

      // player1側のLabelは180度回転させる
        rotate(consoleView1, 180)
        rotate(consoleView1.BtnSV, 180)

        // game開始
        gameStart()
        
    }
    
    func rotate(_ UIView: UIView, _ angle: CGFloat){
        
        let oneDegree = CGFloat.pi/180
        
        UIView.transform = CGAffineTransform(rotationAngle: CGFloat(oneDegree*angle))
        
    }
    
    func loadGameState(){
        
        imageView1.image = UIImage(named: gameState[0][0])
        imageView2.image = UIImage(named: gameState[0][1])
        imageView3.image = UIImage(named: gameState[0][2])
        imageView4.image = UIImage(named: gameState[0][3])
        imageView5.image = UIImage(named: gameState[0][4])
        imageView6.image = UIImage(named: gameState[1][0])
        imageView7.image = UIImage(named: gameState[1][1])
        imageView8.image = UIImage(named: gameState[1][2])
        imageView9.image = UIImage(named: gameState[1][3])
        imageView10.image = UIImage(named: gameState[1][4])
        imageView11.image = UIImage(named: gameState[2][0])
        imageView12.image = UIImage(named: gameState[2][1])
        imageView13.image = UIImage(named: gameState[2][2])
        imageView14.image = UIImage(named: gameState[2][3])
        imageView15.image = UIImage(named: gameState[2][4])
        imageView16.image = UIImage(named: gameState[3][0])
        imageView17.image = UIImage(named: gameState[3][1])
        imageView18.image = UIImage(named: gameState[3][2])
        imageView19.image = UIImage(named: gameState[3][3])
        imageView20.image = UIImage(named: gameState[3][4])
        imageView21.image = UIImage(named: gameState[4][0])
        imageView22.image = UIImage(named: gameState[4][1])
        imageView23.image = UIImage(named: gameState[4][2])
        imageView24.image = UIImage(named: gameState[4][3])
        imageView25.image = UIImage(named: gameState[4][4])
        imageView26.image = UIImage(named: gameState[5][0])
        imageView27.image = UIImage(named: gameState[5][1])
        imageView28.image = UIImage(named: gameState[5][2])
        imageView29.image = UIImage(named: gameState[5][3])
        imageView30.image = UIImage(named: gameState[5][4])
        imageView31.image = UIImage(named: gameState[6][0])
        imageView32.image = UIImage(named: gameState[6][1])
        imageView33.image = UIImage(named: gameState[6][2])
        imageView34.image = UIImage(named: gameState[6][3])
        imageView35.image = UIImage(named: gameState[6][4])


        
    }
    
    func findLocation(tag: Int) -> Location {
        
        for (x,col) in gameState.enumerated(){
            if col[tag] != ""{
                return Location(x:x, y:tag)
            }
        }
        assertionFailure("Present is missing😢")
        abort()
    }
    

    // game開始時の挙動
    func gameStart() {
        
        restTime = settingTime

        // 勝ち負けLabelを非表示
       consoleView1.winOrLoseLabel.isHidden = true
       consoleView2.winOrLoseLabel.isHidden = true

       // timerLabelに残り時間を反映
       consoleView1.timerLabel.text = "\(restTime)"
       consoleView2.timerLabel.text = "\(restTime)"
       
       // pointを0にセット
       pointNum1 = 0
       pointNum2 = 0
       consoleView1.pointLabel.text = "\(pointNum2)pt"
       consoleView2.pointLabel.text = "\(pointNum2)pt"

        // 始まりのカウントダウン開始
        callLabel.text = "③"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sounds.playSound(fileName: "countDown", extentionName: "mp3")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.callLabel.text = "②"

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.callLabel.text = "①"

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.callLabel.isHidden = true

                        // 画面を初期化
                        self.initailState()
                        
                        //タイマースタート
                        self.timerStart()
                    }
                }
            }
        }
    }

    // 画面の初期状態
    func initailState() {
        
        for y in 0..<gameState[3].count {
            
            gameState[3][y] = RondomPresent()
            
        }
        
        loadGameState()
       
        // Btn有効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: true)
        }
        
    }
    
    func getEmptyGameState() -> [[String]]{
        return
            [
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ["","","","",""],
            ]
    }
    
    
    func timerStart(){
        
        // タイマーを作動
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            if self.restTime > 0 {
                // 残り時間を減らしていく
                self.restTime -= 1
                self.consoleView1.timerLabel.text = "\(self.restTime)"
                self.consoleView2.timerLabel.text = "\(self.restTime)"
                
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

        gameState = getEmptyGameState()
        loadGameState()

        // Btn無効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: false)
        }


        // 結果発表
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.comparePoint()
        }

        //メニュー表示
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.callLabel.isHidden = true
            self.againBtn.isHidden = false
            self.homeBtn.isHidden = false
        }
        
    }
    
    //点数比較
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

    @IBAction func startAgain(_: Any) {
        gameStart()
        sounds.playSound(fileName: "decide", extentionName: "mp3")
        againBtn.isHidden = true
        homeBtn.isHidden = true
        callLabel.isHidden = false
    }
    
    func RondomPresent() -> String{
        let presentNameArray = Array(presentNameAndPoint.keys)
        let n = Int.random(in: 1 ... presentNameArray.count)
        let nextPresent = presentNameArray[n-1]
        return nextPresent
        
    }
    
    //delegateメソッド
    func Up(_ tag: Int) {
        
        var location = findLocation(tag: tag)
        
        let presentName = gameState[location.x][location.y]
        
        gameState[location.x][location.y] = ""
        
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
        
        gameState[location.x][location.y] = presentName
        loadGameState()
        
        if location.x == 0{

            let getPoint = presentNameAndPoint[presentName] ?? 0
            
            playSoundByTypeOfPresent(getPoint)
            
            pointNum1 += getPoint
            
            consoleView1.pointLabel.text = "\(self.pointNum1)pt"
            
            btnLineStatus(btnLine: btnLineArray[tag], status: false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.resetPresent(location: location)
                self.btnLineStatus(btnLine: self.btnLineArray[tag], status: true)
            }
        }
    }
    
    func resetPresent(location: Location){
        gameState[location.x][location.y] = ""
        gameState[3][location.y] = RondomPresent()
        loadGameState()
    }
    
    
    //delegateメソッド
    func Down(_ tag: Int) {
        
        var location = findLocation(tag: tag)
        
        let presentName = gameState[location.x][location.y]
        
        gameState[location.x][location.y] = ""
        
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
        
        gameState[location.x][location.y] = presentName
        loadGameState()
        
        if location.x == 6{
            
            let getPoint = presentNameAndPoint[presentName] ?? 0
            
            playSoundByTypeOfPresent(getPoint)
            
            pointNum2 += getPoint
            
            consoleView2.pointLabel.text = "\(self.pointNum2)pt"
            
            btnLineStatus(btnLine: btnLineArray[tag], status: false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.resetPresent(location: location)
                self.btnLineStatus(btnLine: self.btnLineArray[tag], status: true)
            }
        }
        
    }

    
    func playSoundByTypeOfPresent(_ getpoint: Int){
        //presentが爆弾なら爆発音、それ以外なら得点
        if getpoint == presentNameAndPoint["bomb"] {
            sounds.playSound(fileName: "bomb", extentionName: "mp3")
        } else {
            sounds.playSound(fileName: "getPoint", extentionName: "mp3")
           }
    }

    // btnLineの有効化/無効化を管理
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
