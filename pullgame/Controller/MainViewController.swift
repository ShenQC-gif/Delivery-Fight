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

    
    private var sounds = Sounds()
    
    @IBOutlet var conveyor1: UIImageView!
    @IBOutlet var conveyor2: UIImageView!
    @IBOutlet var conveyor3: UIImageView!
    @IBOutlet var conveyor4: UIImageView!
    @IBOutlet var conveyor5: UIImageView!

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


    @IBOutlet var callLabel: UILabel!
    @IBOutlet var againBtn: UIButton!
    @IBOutlet var homeBtn: UIButton!

    var scoreNum1 = 0
    var scoreNum2 = 0

    var timer = Timer()
    var settingTime = 0
    var restTime = 0

    static let itemArray:[ItemType] = [Apple(), Grape(), Melon(), Peach(), Banana(), Cherry(), Bomb()]

    static func makeInitialState() -> [BeltState] {
        [
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
        ]
    }

    private var beltStates = MainViewController.makeInitialState()

    func configureUI(beltStates: [BeltState]) {
        // ここでUIを適切に設定する
        for i in 0..<beltStates.count{
            let name = beltStates[i].item.imageName
            switch beltStates[i].itemPosition{
                case let .onBelt(poistion):
                    switch poistion {
                        case .pos0:
                            imageArray[i][1].image = UIImage(named: name)
                            imageArray[i][2].image = UIImage(named: "")
                        case .pos1:
                            imageArray[i][1].image = UIImage(named: "")
                            imageArray[i][2].image = UIImage(named: name)
                            imageArray[i][3].image = UIImage(named: "")
                        case .pos2:
                            imageArray[i][0].image = UIImage(named: "")
                            imageArray[i][2].image = UIImage(named: "")
                            imageArray[i][3].image = UIImage(named: name)
                            imageArray[i][4].image = UIImage(named: "")
                            imageArray[i][6].image = UIImage(named: "")
                        case .pos3:
                            imageArray[i][3].image = UIImage(named: "")
                            imageArray[i][4].image = UIImage(named: name)
                            imageArray[i][5].image = UIImage(named: "")
                        case .pos4:
                            imageArray[i][4].image = UIImage(named: "")
                            imageArray[i][5].image = UIImage(named: name)
                    }

                case let .outOfBelt(player):
                    switch player {
                        case .player1:
                            imageArray[i][0].image = UIImage(named: name)
                            imageArray[i][1].image = UIImage(named: "")
                        case .player2:
                            imageArray[i][5].image = UIImage(named: "")
                            imageArray[i][6].image = UIImage(named: name)
                    }
            }
        }
    }

    func didTapUp(_ tag: Int) {
        var newItemPosition : ItemPosition
        let beltState = beltStates[tag]

        switch beltState.itemPosition {

            case let .onBelt(position):
                newItemPosition = position.prev().map {ItemPosition.onBelt($0)} ?? ItemPosition.outOfBelt(.player1)
            case .outOfBelt(_):
                newItemPosition = ItemPosition.onBelt(.center)
        }

        beltStates[tag] = BeltState(item: beltState.item, itemPosition: newItemPosition)
        configureUI(beltStates: beltStates)
        checkIfOutOfBelt(beltState: beltStates[tag], player: .player1, tag: tag)

    }

    func checkIfOutOfBelt(beltState: BeltState, player: Player, tag: Int){

        if beltState.itemPosition == ItemPosition.outOfBelt(player){

            switch player {

                case .player1:
                    scoreNum1 += beltState.item.score
                    consoleView1.scoreLabel.text = "\(scoreNum1)pt"
                case .player2:
                    scoreNum2 += beltState.item.score
                    consoleView2.scoreLabel.text = "\(scoreNum2)pt"
            }

            btnLineStatus(btnLine: btnLineArray[tag], status: false)

            let newItem = MainViewController.itemArray.randomElement() ?? Apple()
            let newItemPosition = ItemPosition.onBelt(.center)
            beltStates[tag] = BeltState(item: newItem, itemPosition: newItemPosition)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.configureUI(beltStates: self.beltStates)
                self.btnLineStatus(btnLine: self.btnLineArray[tag], status: true)
            }
        }

    }

    func didTapDown(_ tag: Int) {
        var newItemPosition : ItemPosition
        let beltState = beltStates[tag]

        switch beltState.itemPosition {

            case let .onBelt(position):
                newItemPosition = position.next().map {ItemPosition.onBelt($0)} ?? ItemPosition.outOfBelt(.player2)
            case .outOfBelt(_):
                newItemPosition = ItemPosition.onBelt(.center)
        }

        beltStates[tag] = BeltState(item: beltState.item, itemPosition: newItemPosition)
        configureUI(beltStates: beltStates)
        checkIfOutOfBelt(beltState: beltStates[tag], player: .player2, tag: tag)

    }

    
    // btnを1列ごとに管理
    var btnLine1: [UIButton] = []
    var btnLine2: [UIButton] = []
    var btnLine3: [UIButton] = []
    var btnLine4: [UIButton] = []
    var btnLine5: [UIButton] = []
    
    // btnLineを一括管理
    var btnLineArray : [[UIButton]] = []

    private var imageArray : [[UIImageView]] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        imageArray  = [
            [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7],
            [imageView8, imageView9, imageView10, imageView11, imageView12, imageView13, imageView14],
            [imageView15, imageView16, imageView17, imageView18, imageView19, imageView20, imageView21],
            [imageView22, imageView23, imageView24, imageView25, imageView26, imageView27, imageView28],
            [imageView29, imageView30, imageView31, imageView32, imageView33, imageView34, imageView35]
        ]

        //Btnを一列毎に管理
        btnLine1 = [consoleView1.upBtn0,consoleView1.downBtn0,consoleView2.upBtn0,consoleView2.downBtn0]
        btnLine2 = [consoleView1.upBtn1,consoleView1.downBtn1,consoleView2.upBtn1,consoleView2.downBtn1]
        btnLine3 = [consoleView1.upBtn2,consoleView1.downBtn2,consoleView2.upBtn2,consoleView2.downBtn2]
        btnLine4 = [consoleView1.upBtn3,consoleView1.downBtn3,consoleView2.upBtn3,consoleView2.downBtn3]
        btnLine5 = [consoleView1.upBtn4,consoleView1.downBtn4,consoleView2.upBtn4,consoleView2.downBtn4]
        
        //btnLineを一括管理
        btnLineArray = [btnLine1, btnLine2, btnLine3, btnLine4, btnLine5]


        againBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        homeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

        // player1側のLabelは180度回転させる
        rotate(consoleView1, 180)
        //ボタンだけは元に戻す
        rotate(consoleView1.BtnSV, 180)
        
        // timerLabelに残り時間を反映
        loadTime(settingTime)

        configureUI(beltStates: beltStates)

        // game開始
//        gameStart()
        
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
        

        
        // 勝ち負けLabelを非表示
       consoleView1.winOrLoseLabel.isHidden = true
       consoleView2.winOrLoseLabel.isHidden = true
        
       // pointを0にセット
        scoreNum1 = 0
        scoreNum2 = 0
       consoleView1.scoreLabel.text = "\(scoreNum1)pt"
       consoleView2.scoreLabel.text = "\(scoreNum2)pt"
    }
    
    // カウントダウン開始後の状態。
    func afterCountDown() {
        
        callLabel.isHidden = true

        //タイマースタート
        timerStart()
            
        // Btn有効化
        for btnLine in btnLineArray {
            btnLineStatus(btnLine: btnLine, status: true)
        }
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
   
        if scoreNum1 > scoreNum2 {
           
           consoleView1.winOrLoseLabel.text = "Win! "
           consoleView1.winOrLoseLabel.textColor = UIColor.red
           consoleView2.winOrLoseLabel.text = "...Lose"
           consoleView2.winOrLoseLabel.textColor = UIColor.blue
           
       } else if scoreNum1 < scoreNum2 {

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
    }

    //presentの種類によって音声を再生
    func playSoundByTypeOfPresent(_ beltState: BeltState){
        //presentが爆弾なら爆発音、それ以外なら得点
        if beltState.item.isBomb {
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
