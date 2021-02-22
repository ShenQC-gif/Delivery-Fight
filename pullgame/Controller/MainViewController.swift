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

    private var beltStates = MainViewController.makeInitialState()
    private var sounds = Sounds()
    private var timeLimit = TimeLimit()
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

    @IBOutlet weak private var consoleView1: CustomView!
    @IBOutlet weak private var consoleView2: CustomView!

    private var imageViewArrays = [[UIImageView]]()
    @IBOutlet weak private var imageView1: UIImageView!
    @IBOutlet weak private var imageView2: UIImageView!
    @IBOutlet weak private var imageView3: UIImageView!
    @IBOutlet weak private var imageView4: UIImageView!
    @IBOutlet weak private var imageView5: UIImageView!
    @IBOutlet weak private var imageView6: UIImageView!
    @IBOutlet weak private var imageView7: UIImageView!
    @IBOutlet weak private var imageView8: UIImageView!
    @IBOutlet weak private var imageView9: UIImageView!
    @IBOutlet weak private var imageView10: UIImageView!
    @IBOutlet weak private var imageView11: UIImageView!
    @IBOutlet weak private var imageView12: UIImageView!
    @IBOutlet weak private var imageView13: UIImageView!
    @IBOutlet weak private var imageView14: UIImageView!
    @IBOutlet weak private var imageView15: UIImageView!
    @IBOutlet weak private var imageView16: UIImageView!
    @IBOutlet weak private var imageView17: UIImageView!
    @IBOutlet weak private var imageView18: UIImageView!
    @IBOutlet weak private var imageView19: UIImageView!
    @IBOutlet weak private var imageView20: UIImageView!
    @IBOutlet weak private var imageView21: UIImageView!
    @IBOutlet weak private var imageView22: UIImageView!
    @IBOutlet weak private var imageView23: UIImageView!
    @IBOutlet weak private var imageView24: UIImageView!
    @IBOutlet weak private var imageView25: UIImageView!
    @IBOutlet weak private var imageView26: UIImageView!
    @IBOutlet weak private var imageView27: UIImageView!
    @IBOutlet weak private var imageView28: UIImageView!
    @IBOutlet weak private var imageView29: UIImageView!
    @IBOutlet weak private var imageView30: UIImageView!
    @IBOutlet weak private var imageView31: UIImageView!
    @IBOutlet weak private var imageView32: UIImageView!
    @IBOutlet weak private var imageView33: UIImageView!
    @IBOutlet weak private var imageView34: UIImageView!
    @IBOutlet weak private var imageView35: UIImageView!

    @IBOutlet private var callLabel: UILabel!
    @IBOutlet private var againBtn: UIButton!
    @IBOutlet private var homeBtn: UIButton!

    private var timer = Timer()
    private var restTime = Int()

    // btnを1列ごとに管理
    private var btnLine1 = [UIButton]()
    private var btnLine2 = [UIButton]()
    private var btnLine3 = [UIButton]()
    private var btnLine4 = [UIButton]()
    private var btnLine5 = [UIButton]()
    // btnLineを一括管理
    private var btnLineArrays = [[UIButton]]()

    /*-------------------画面読込-------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()



        imageViewArrays  = [
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
        btnLineArrays = [btnLine1, btnLine2, btnLine3, btnLine4, btnLine5]


        againBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        homeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

        // player1側のLabelは180度回転させる
        rotate(consoleView1, 180)
        //ボタンだけは元に戻す
        rotate(consoleView1.BtnSV, 180)

        // game開始
        gameStart()
        
    }

    // Viewを回転させる
    private func rotate(_ UIView: UIView, _ angle: CGFloat){
        let oneDegree = CGFloat.pi/180
        UIView.transform = CGAffineTransform(rotationAngle: CGFloat(oneDegree*angle))

    }

    /*-------------------game開始時の挙動-------------------*/

    //game開始(再開)
    private func gameStart() {

        // 画面初期化
        beforeCountDown()

        // カウントダウン開始
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

    //画面初期化
    private func beforeCountDown() {

        //各種表示/非表示切り替え
        againBtn.isHidden = true
        homeBtn.isHidden = true
        callLabel.isHidden = false

        // 勝ち負けLabelを非表示
        consoleView1.resultLabel.isHidden = true
        consoleView2.resultLabel.isHidden = true

        consoleView1.scoreLabel.text = "\(consoleView1.scoreNum)pt"
        consoleView2.scoreLabel.text = "\(consoleView2.scoreNum)pt"

        timeLimit = TimeLimit(rawValue: UserDefaults.standard.integer(forKey: "Time")) ?? .thirty
        restTime = timeLimit.rawValue
        loadTime(restTime)

    }

    // カウントダウン終了後の状態
    private func afterCountDown() {

        callLabel.isHidden = true

        // Btn有効化
        for btnLine in btnLineArrays {
            btnLineStatus(btnLine: btnLine, status: true)
        }

        //imageViewを表示
        for imageArray in imageViewArrays{
            for image in imageArray{
                image.isHidden = false
            }
        }

        beltStates = MainViewController.makeInitialState()
        configureUI(beltStates: beltStates)

        //タイマースタート
        timerStart()

    }

    private func timerStart(){
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

    private func loadTime(_ time: Int){
        consoleView1.timerLabel.text = "\(time)"
        consoleView2.timerLabel.text = "\(time)"
    }

    /*-------------------game中の操作-------------------*/

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

    private func configureUI(beltStates: [BeltState]) {
        // ここでUIを適切に設定する
        for i in 0..<beltStates.count{

            let name = beltStates[i].item.imageName

            for imageView in imageViewArrays[i]{
                imageView.image = UIImage(named: "")
            }

            switch beltStates[i].itemPosition{
                case let .onBelt(poistion):
                    switch poistion {
                        case .pos0:
                            imageViewArrays[i][1].image = UIImage(named: name)
                        case .pos1:
                            imageViewArrays[i][2].image = UIImage(named: name)
                        case .pos2:
                            imageViewArrays[i][3].image = UIImage(named: name)
                        case .pos3:
                            imageViewArrays[i][4].image = UIImage(named: name)
                        case .pos4:
                            imageViewArrays[i][5].image = UIImage(named: name)
                    }

                case let .outOfBelt(player):
                    switch player {
                        case .player1:
                            imageViewArrays[i][0].image = UIImage(named: name)
                        case .player2:
                            imageViewArrays[i][6].image = UIImage(named: name)
                    }
            }
        }
    }

    private func checkIfOutOfBelt(beltState: BeltState, player: Player, tag: Int){
        if beltState.itemPosition == ItemPosition.outOfBelt(player){
            playSoundByTypeOfPresent(beltState)
            updateScore(beltState: beltState, player: player)
            resetBeltState(tag)
        }
    }

    private func updateScore(beltState: BeltState, player:Player){
        switch player {

            case .player1:
                consoleView1.scoreNum += beltState.item.score
                consoleView1.scoreLabel.text = "\(consoleView1.scoreNum)pt"
            case .player2:
                consoleView2.scoreNum += beltState.item.score
                consoleView2.scoreLabel.text = "\(consoleView2.scoreNum)pt"
        }
    }

    private func resetBeltState(_ tag: Int){
        btnLineStatus(btnLine: btnLineArrays[tag], status: false)

        let newItem = MainViewController.itemArray.randomElement() ?? Apple()
        let newItemPosition = ItemPosition.onBelt(.center)
        beltStates[tag] = BeltState(item: newItem, itemPosition: newItemPosition)

        //0.5秒後に、残り時間がまだあればItemを再セット
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.restTime > 0 {
                self.configureUI(beltStates: self.beltStates)
                self.btnLineStatus(btnLine: self.btnLineArrays[tag], status: true)
            }
        }
    }

    /*-------------------game終了後の挙動-------------------*/

    // game終了
    private func gameFinish() {
        
        sounds.playSound(fileName: "finish", extentionName: "mp3")
        
        //画面上からimageViewを消す
        for imageArray in imageViewArrays{
            for image in imageArray{
                image.isHidden = true
            }
        }

        // Btn無効化
        for btnLine in btnLineArrays {
            btnLineStatus(btnLine: btnLine, status: false)
        }

        callLabel.isHidden = false
        callLabel.text = "Finish!!"

        // 結果発表
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            self.comparePoint()
            
            //時間差で表示されることがあるため、もう一度Btn無効化
            for btnLine in self.btnLineArrays {
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
    private func comparePoint(){
        
        consoleView1.resultLabel.isHidden = false
        consoleView2.resultLabel.isHidden = false

        if consoleView1.scoreNum > consoleView2.scoreNum {
            consoleView1.resultLabel.text = Result.returnResult(.win)().text
            consoleView1.resultLabel.textColor = Result.returnResult(.win)().color
            consoleView2.resultLabel.text = Result.returnResult(.lose)().text
            consoleView2.resultLabel.textColor = Result.returnResult(.lose)().color

        } else if consoleView1.scoreNum < consoleView2.scoreNum {
            consoleView1.resultLabel.text = Result.returnResult(.lose)().text
            consoleView1.resultLabel.textColor = Result.returnResult(.lose)().color
            consoleView2.resultLabel.text = Result.returnResult(.win)().text
            consoleView2.resultLabel.textColor = Result.returnResult(.win)().color
        } else {
            consoleView1.resultLabel.text = Result.returnResult(.draw)().text
            consoleView1.resultLabel.textColor = Result.returnResult(.draw)().color
            consoleView2.resultLabel.text = Result.returnResult(.draw)().text
            consoleView2.resultLabel.textColor = Result.returnResult(.draw)().color
        }

    }
    

    @IBAction private func startAgain(_: Any) {
        gameStart()
        sounds.playSound(fileName: "decide", extentionName: "mp3")
    }

    /*-------------------その他共通-------------------*/
    //presentの種類によって音声を再生
    private func playSoundByTypeOfPresent(_ beltState: BeltState){
        //presentが爆弾なら爆発音、それ以外なら得点
        if beltState.item.isBomb {
            sounds.playSound(fileName: "bomb", extentionName: "mp3")
        } else {
            sounds.playSound(fileName: "getPoint", extentionName: "mp3")
        }
    }

    // 1列毎のbtnLineの有効化/無効化を管理
    private func btnLineStatus(btnLine: [UIButton], status: Bool) {
        for btn in btnLine {
            btn.isEnabled = status
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toStart" {
            sounds.playSound(fileName: "decide", extentionName: "mp3")
        }
    }
}
