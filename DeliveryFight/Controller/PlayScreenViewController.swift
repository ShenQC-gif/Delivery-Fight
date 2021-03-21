//
//  PlayScreenViewController.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/16.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class PlayScreenViewController: UIViewController {
    @IBOutlet private var beltView1: BeltView!
    @IBOutlet private var beltView2: BeltView!
    @IBOutlet private var beltView3: BeltView!
    @IBOutlet private var beltView4: BeltView!
    @IBOutlet private var beltView5: BeltView!

    @IBOutlet private var player1Buttons1: UpDownButtonView!
    @IBOutlet private var player1Buttons2: UpDownButtonView!
    @IBOutlet private var player1Buttons3: UpDownButtonView!
    @IBOutlet private var player1Buttons4: UpDownButtonView!
    @IBOutlet private var player1Buttons5: UpDownButtonView!

    @IBOutlet private var player2Buttons1: UpDownButtonView!
    @IBOutlet private var player2Buttons2: UpDownButtonView!
    @IBOutlet private var player2Buttons3: UpDownButtonView!
    @IBOutlet private var player2Buttons4: UpDownButtonView!
    @IBOutlet private var player2Buttons5: UpDownButtonView!

    @IBOutlet private var player1ScoreView: ScoreView!
    @IBOutlet private var player2ScoreView: ScoreView!

    @IBOutlet private var player1TimerView: TimerView!
    @IBOutlet private var player2TimerView: TimerView!

    @IBOutlet private var player1ResultView: ResultView!
    @IBOutlet private var player2ResultView: ResultView!

    @IBOutlet private var announceLabel: UILabel!
    @IBOutlet private var menuSV: UIStackView!

    private var gameStatus = GameStatus.firstStatus
    private var sounds = Sounds()


    static let itemArray: [ItemType] = [Apple(), Grape(), Melon(), Peach(), Banana(), Cherry(), Bomb()]
    static func makeInitialState() -> [BeltState] {
        [
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
            BeltState(item: itemArray.randomElement() ?? Apple(), itemPosition: .onBelt(.center)),
        ]
    }

    // 具体的なBeltの状態(Itemの種類と位置)を設定
    private var beltStatus = [BeltState]()

    private var beltViews: [BeltView] {
        [
            beltView1,
            beltView2,
            beltView3,
            beltView4,
            beltView5,
        ]
    }

    private var player1Buttons: [UpDownButtonView] {
        [
            player1Buttons1,
            player1Buttons2,
            player1Buttons3,
            player1Buttons4,
            player1Buttons5,
        ]
    }

    private var player2Buttons: [UpDownButtonView] {
        [
            player2Buttons1,
            player2Buttons2,
            player2Buttons3,
            player2Buttons4,
            player2Buttons5,
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configure()
    }

    // ゲームを始める前に一度だけ設定すれば良いもの設定
    private func setUp() {
        // 各ボタンを押した時の処理を実装
        player1Buttons.enumerated().forEach { offset, UpDownButtonView in
            UpDownButtonView.configure(
                didTapUp: { [weak self] in
                    self?.itemUp(index: offset)
                },
                didTapDown: { [weak self] in
                    self?.itemDown(index: offset)
                }
            )
        }

        player2Buttons.enumerated().forEach { offset, UpDownButtonView in
            UpDownButtonView.configure(
                didTapUp: { [weak self] in
                    self?.itemUp(index: offset)
                },
                didTapDown: { [weak self] in
                    self?.itemDown(index: offset)
                }
            )
        }

        // player1側のviewを反転
        rotate(player1ScoreView, 180)
        rotate(player1TimerView, 180)
        rotate(player1ResultView, 180)

        //残り時間が0になった時の挙動をplayer1のみに渡す(どちらか一つに渡せばよくplayer2にも渡す必要なし)
        player1TimerView.configure(timeOverHandler: { [weak self] in
            self?.changeGameStatus()
        })
        player2TimerView.configure(timeOverHandler: nil)

    }

    // Viewを回転させる
    private func rotate(_ UIView: UIView, _ angle: CGFloat) {
        let oneDegree = CGFloat.pi / 180
        UIView.transform = CGAffineTransform(rotationAngle: CGFloat(oneDegree * angle))
    }

    private func changeGameStatus(){
        gameStatus = .afterPlay
        configure()
    }

    // ゲーム全体の状態によって表示(内容・方法)が変わるものを規定
    private func configure() {
        switch gameStatus {
        // ゲーム前のカウントダウン時
        case let .countDownBeforPlay(countDown: countDown):
            switch countDown {
            case .three:

                sounds.playSound(rosource: CountDown())

                menuSV.isHidden = true

                announceLabel.isHidden = false
                announceLabel.text = "③"

                player1ResultView.isHidden = true
                player2ResultView.isHidden = true

                // ボタンを無効化
                for button in player1Buttons {
                    button.status(isEnabled: false)
                }
                for button in player2Buttons {
                    button.status(isEnabled: false)
                }

                // scoreをリセット
                player1ScoreView.resetScore()
                player2ScoreView.resetScore()

                player1TimerView.setInitialTime()
                player2TimerView.setInitialTime()

                // 1秒後に次のカウントダウンへ
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.gameStatus = .countDownBeforPlay(countDown: .two)
                    self.configure()
                }

            case .two:
                announceLabel.text = "②"
                // 1秒後に次のカウントダウンへ
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.gameStatus = .countDownBeforPlay(countDown: .one)
                    self.configure()
                }

            case .one:
                announceLabel.text = "①"
                // 1秒後に次のゲーム中のステータスへ
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.gameStatus = .onPlay
                    self.configure()
                }
            }

        // ゲーム中
        case .onPlay:

            announceLabel.isHidden = true

            // beltViewにbeltStatusを渡し、itemの情報を反映
            beltStatus = PlayScreenViewController.makeInitialState()
            zip(beltStatus, beltViews).forEach {
                $1.configure(beltState: $0)
            }

            // itemを表示
            for beltView in beltViews {
                beltView.hideItem(hide: false)
            }

            // ボタンを有効化
            for button in player1Buttons {
                button.status(isEnabled: true)
            }
            for button in player2Buttons {
                button.status(isEnabled: true)
            }

            // タイマースタート
            player1TimerView.timerStart()
            player2TimerView.timerStart()

        // ゲーム終了時
        case .afterPlay:

            announceLabel.isHidden = false
            announceLabel.text = "Finish!!"

            sounds.playSound(rosource: Finish())

            // item非表示
            for beltView in beltViews {
                beltView.hideItem(hide: true)
            }

            // ボタンを無効化
            for button in player1Buttons {
                button.status(isEnabled: false)
            }
            for button in player2Buttons {
                button.status(isEnabled: false)
            }

            // 2秒後に結果を表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.player1ResultView.isHidden = false
                self.player2ResultView.isHidden = false
                self.showResult()

                // 更に2秒後にmenu表示
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.announceLabel.isHidden = true
                    self.menuSV.isHidden = false
                }
            }
        }
    }

    private func showResult() {
        func player1Result() -> GameResult {
            if player1ScoreView.score.score > player2ScoreView.score.score {
                return .win
            } else if player1ScoreView.score.score < player2ScoreView.score.score {
                return .lose
            } else {
                return .draw
            }
        }

        func player2Result() -> GameResult {
            GameResult.opponentResult(player1Result())()
        }

        player1ResultView.configure(gameResult: player1Result())
        player2ResultView.configure(gameResult: player2Result())
    }

    private func itemUp(index: Int) {
        let belt = beltStatus[index]
        let item = belt.item
        let newItemPosition: ItemPosition = {
            switch belt.itemPosition {
            case let .onBelt(position):
                return position.prev().map { ItemPosition.onBelt($0) } ?? ItemPosition.outOfBelt(.player1)
            case .outOfBelt:
                return ItemPosition.onBelt(.center)
            }
        }()

        beltStatus[index] = BeltState(item: item, itemPosition: newItemPosition)
        beltViews[index].configure(beltState: beltStatus[index])
        checkIfOutOfBelt(index: index)
    }

    private func itemDown(index: Int) {
        let belt = beltStatus[index]
        let item = belt.item
        let newItemPosition: ItemPosition = {
            switch belt.itemPosition {
            case let .onBelt(position):
                return position.next().map { ItemPosition.onBelt($0) } ?? ItemPosition.outOfBelt(.player2)
            case .outOfBelt:
                return ItemPosition.onBelt(.center)
            }
        }()

        beltStatus[index] = BeltState(item: item, itemPosition: newItemPosition)
        beltViews[index].configure(beltState: beltStatus[index])
        checkIfOutOfBelt(index: index)
    }

    // itemがbeltの外(player側)に落ちたの時の処理
    private func checkIfOutOfBelt(index: Int) {

        switch beltStatus[index].itemPosition {

            //itemがbeltの外(player側)に落ちたの時
        case let .outOfBelt(player):
            //一旦ボタン無効化
            player1Buttons[index].status(isEnabled: false)
            player2Buttons[index].status(isEnabled: false)

            //音を再生
            playSoundByTypeOfItem(item: beltStatus[index].item)

            //itemが落ちたplayerのスコアを更新
            switch player {
            case .player1:
                player1ScoreView.updateScore(item: beltStatus[index].item)
            case .player2:
                player2ScoreView.updateScore(item: beltStatus[index].item)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //0.5秒後にまだゲーム中ならボタンを有効化してベルトを初期化
                if self.gameStatus == .onPlay {
                    //ボタン有効化
                    self.player1Buttons[index].status(isEnabled: true)
                    self.player2Buttons[index].status(isEnabled: true)
                    self.resetBelt(index: index)
                }
            }

        default:
            break
        }
    }

    //ベルトを初期化
    private func resetBelt(index: Int) {
        beltStatus[index] = BeltState(item: randomItem(), itemPosition: .onBelt(.center))
        beltViews[index].configure(beltState: beltStatus[index])
    }

    private func randomItem() -> ItemType {
        return PlayScreenViewController.itemArray.randomElement() ?? Apple()
    }



    // itemの種類によって音声を再生
    private func playSoundByTypeOfItem(item: ItemType) {
        // presentが爆弾なら爆発音、それ以外なら得点
        if item.isBomb {
            sounds.playSound(rosource: GetBomb())
        } else {
            sounds.playSound(rosource: GetPoint())
        }
    }

    @IBAction func didTapAgain(_: Any) {
        gameStatus = .countDownBeforPlay(countDown: .startingStatus)
        sounds.playSound(rosource: Decide())
        configure()
    }

    @IBAction func didTapHome(_: Any) {
        dismiss(animated: true, completion: nil)
        sounds.playSound(rosource: Decide())
    }
}
