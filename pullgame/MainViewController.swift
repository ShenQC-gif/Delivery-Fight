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

    var conveyorTop : CGFloat = 0
    var conveyorButtom : CGFloat = 0
    var conveyorHeight : CGFloat = 0
    
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
    
    // btnLineを一括管理
    var btnLineArray : [[UIButton]] = []

    // present名を管理
    var presentNameAndPoint = [String:Int]()
    
    var presentViewArray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        btnLine1 = [pullBtn11, pushBtn11, pushBtn21, pullBtn21]
        btnLine2 = [pullBtn12, pushBtn12, pushBtn22, pullBtn22]
        btnLine3 = [pullBtn13, pushBtn13, pushBtn23, pullBtn23]
        btnLine4 = [pullBtn14, pushBtn14, pushBtn24, pullBtn24]
        btnLine5 = [pullBtn15, pushBtn15, pushBtn25, pullBtn25]
        
        btnLineArray = [btnLine1, btnLine2, btnLine3, btnLine4, btnLine5]

        presentViewArray = [present1, present2, present3, present4, present5]

        presentNameAndPoint = ["apple":10, "grape":20, "melon":30, "peach":40, "banana":50, "cherry":60, "diamond":100, "bomb":-50]

        // 以下各座標を設定
        conveyorHeight = height*0.35  //conveyorの高さは画面の0.35
        conveyorTop = height/2 - conveyorHeight/2  //conveyorの上端の座標
        conveyorButtom = height/2 + conveyorHeight/2  //conveyorの下端の座標
        
        //presetnは正方形で、一辺の長さはwidth*0.16
        let presentLenght = width*0.16
        
        //conveyor全体の幅はauto layoutでwidth*0.9と設定している。従いpresent1のx座標はwidth*0.1/2。
        //presetn3の中点のx座標はwidthの中点と同じ。そこから一辺の長さの半分がそのx座標。
        //上記二点から他のpresetnのx座標を算出。
        present1.frame = CGRect(x: width*0.050, y: 0, width:presentLenght, height:presentLenght)
        present2.frame = CGRect(x: width*0.235, y: 0, width:presentLenght, height:presentLenght)
        present3.frame = CGRect(x: width*0.420, y: 0, width:presentLenght, height:presentLenght)
        present4.frame = CGRect(x: width*0.605, y: 0, width:presentLenght, height:presentLenght)
        present5.frame = CGRect(x: width*0.790, y: 0, width:presentLenght, height:presentLenght)

        // timerに丸枠線を設定
        timerLabel1.layer.borderWidth = 1
        timerLabel1.layer.cornerRadius = 1.5/32

        timerLabel2.layer.borderWidth = 1
        timerLabel2.layer.cornerRadius = 1.5/32
        // timerLabelに残り時間を反映
        timerLabel1.text = String(restTime)
        timerLabel2.text = String(restTime)

        againBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        homeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

        // 画面にimageviewを貼り付け、90度回転させる
        for presentView in presentViewArray{
            view.addSubview(presentView)
            rotate(presentView, 90)
        }

        // player1側のLabelは180度回転させる
        rotate(pointLabel1, 180)
        rotate(timerLabel1, 180)
        rotate(winLoseLabel1, 180)

        // game開始
        gameStart()
    }
    
    func rotate(_ UIView: UIView, _ angle: CGFloat){
        
        let oneDegree = CGFloat.pi/180
        
        UIView.transform = CGAffineTransform(rotationAngle: CGFloat(oneDegree*angle))
        
    }
    

    // game開始時の挙動
    func gameStart() {
        
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

        // 各presentの位置を初期位置に、ランダムにセットして表示
        for presentView in presentViewArray {
            presentView.center.y = height/2  //y座標はconveyorの中点、つまりheightの中点。
            setPresent(present: presentView)
            presentView.isHidden = false
        }
       
        // Btn有効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: true)
        }
        
    }
    
    
    func timerStart(){
        
        // タイマーを作動
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            if self.restTime > 0 {
                // 残り時間を減らしていく
                self.restTime -= 1
                self.timerLabel1.text = "\(self.restTime)"
                self.timerLabel2.text = "\(self.restTime)"
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
        for presentView in presentViewArray {
            presentView.isHidden = true
        }

        // Btn無効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: false)
        }


        // 結果発表
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.comparePoint()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.callLabel.isHidden = true
            self.againBtn.isHidden = false
            self.homeBtn.isHidden = false
        }
        
    }
    
    func comparePoint(){
        
        winLoseLabel1.isHidden = false
        winLoseLabel2.isHidden = false
    
        if pointNum1 > pointNum2 {
            winLoseLabel1.text = "Win! "
            winLoseLabel1.textColor = UIColor.red
            winLoseLabel2.text = "...Lose"
            winLoseLabel2.textColor = UIColor.blue
            
        } else if pointNum1 < pointNum2 {
            winLoseLabel1.text = "...Lose"
            winLoseLabel1.textColor = UIColor.blue
            winLoseLabel2.text = "Win! "
            winLoseLabel2.textColor = UIColor.red
            
        } else {
            winLoseLabel1.text = "Draw!"
            winLoseLabel1.textColor = UIColor.black
            winLoseLabel2.text = "Draw!"
            winLoseLabel2.textColor = UIColor.black
        }
 
    }

    @IBAction func startAgain(_: Any) {
        gameStart()
        sounds.playSound(fileName: "decide", extentionName: "mp3")
        againBtn.isHidden = true
        homeBtn.isHidden = true
        callLabel.isHidden = false
    }
    
    //上向矢印Btnを左から0,1,2...とタグを打ち、その番号に該当するpresetnViewArrayのArrayを上に移動
    @IBAction func movePresentToUpside(_ sender: Any) {
        
        //タグを取得
        let tag = ((sender as AnyObject).tag)!
                
        //conveyorを9等分し、上から下まで9マスあるイメージ。初期位置はその5マス目。
        presentViewArray[tag].center.y -= conveyorHeight/9
        
        // どちらの得点か判定
        whosePresent(present: presentViewArray[tag], btnLine: btnLineArray[tag])
        
    }
    
    //下向矢印Btnを左から0,1,2...とタグを打ち、その番号に該当するpresetnViewArrayのArrayを下に移動
    @IBAction func movePresentToDownside(_ sender: Any) {
        
        let tag = ((sender as AnyObject).tag)!
        
        presentViewArray[tag].center.y += conveyorHeight/9
        
        // どちらの得点か判定
        whosePresent(present: presentViewArray[tag], btnLine: btnLineArray[tag])
        
    }

    // どちらの得点か判定
    func whosePresent(present: UIImageView, btnLine: [UIButton]) {
        // 得点の数字を入れる箱を用意
        var getPoint = 0
        
        //presentの名前を取得し、それに応じて点数を計算する
        if let presentName = present.image?.accessibilityIdentifier{
            getPoint = presentNameAndPoint[presentName] ?? 0
        }

        // presentがplayer1側に届いた時
        if present.center.y < conveyorTop {
            
            playSoundByTypeOfPresent(getPoint)
            // 一旦Btn無効化
            btnLineStatus(btnLine: btnLine, status: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                
                self.pointNum1 += getPoint
                
                self.pointLabel1.text = "\(self.pointNum1)pt"
                
                // presentのviewを初期位置に、新しいpresentをランダムにセット
                present.center.y = self.height/2
                
                self.setPresent(present: present)

                // Btn有効化
                self.btnLineStatus(btnLine: btnLine, status: true)
            }
        }

        // presentがplayer2側に届いた時
        if present.center.y  > conveyorButtom {
           
            playSoundByTypeOfPresent(getPoint)

            btnLineStatus(btnLine: btnLine, status: false)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {

                self.pointNum2 += getPoint
                
                self.pointLabel2.text = "\(self.pointNum2)pt"
                

                present.center.y = self.height/2
                
                self.setPresent(present: present)

                self.btnLineStatus(btnLine: btnLine, status: true)

                
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
 
    // presentをランダムにセット
    func setPresent(present: UIImageView) {
        let presentNameArray = Array(presentNameAndPoint.keys)
        let n = Int.random(in: 1 ... presentNameArray.count)
        let nextPresent = presentNameArray[n-1]
        present.image = UIImage(named: nextPresent)
        present.image?.accessibilityIdentifier = nextPresent
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
//
//extension UIImageView {
//    func getFileName() -> String? {
//        return image?.accessibilityIdentifier
//    }
//}

