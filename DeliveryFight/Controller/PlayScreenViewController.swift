//
//  PlayScreenViewController.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/16.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class PlayScreenViewController: UIViewController {

    @IBOutlet private weak var beltView1: BeltView!
    @IBOutlet private weak var beltView2: BeltView!
    @IBOutlet private weak var beltView3: BeltView!
    @IBOutlet private weak var beltView4: BeltView!
    @IBOutlet private weak var beltView5: BeltView!

    @IBOutlet private weak var player1Buttons1: UpDownButtonView!
    @IBOutlet private weak var player1Buttons2: UpDownButtonView!
    @IBOutlet private weak var player1Buttons3: UpDownButtonView!
    @IBOutlet private weak var player1Buttons4: UpDownButtonView!
    @IBOutlet private weak var player1Buttons5: UpDownButtonView!

    @IBOutlet private weak var player2Buttons1: UpDownButtonView!
    @IBOutlet private weak var player2Buttons2: UpDownButtonView!
    @IBOutlet private weak var player2Buttons3: UpDownButtonView!
    @IBOutlet private weak var player2Buttons4: UpDownButtonView!
    @IBOutlet private weak var player2Buttons5: UpDownButtonView!

    @IBOutlet private weak var player1ScoreView: ScoreView!
    @IBOutlet private weak var player2ScoreView: ScoreView!

    @IBOutlet private weak var player1TimerView: TimerView!
    @IBOutlet private weak var player2TimerView: TimerView!

    private var sounds = Sounds()

    @IBOutlet private weak var announceLabel: UILabel!

    private var beltViews : [BeltView] {
        [
            beltView1,
            beltView2,
            beltView3,
            beltView4,
            beltView5
        ]
    }

    private var player1Buttons : [UpDownButtonView] {
        [
            player1Buttons1,
            player1Buttons2,
            player1Buttons3,
            player1Buttons4,
            player1Buttons5
        ]
    }

    private var player2Buttons : [UpDownButtonView] {
        [
            player2Buttons1,
            player2Buttons2,
            player2Buttons3,
            player2Buttons4,
            player2Buttons5
        ]
    }

    //ここで具体的なBeltの状態(Item,Item位置)を設定
    private var beltStates : [BeltState] = [
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.center)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.center)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.center)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.center)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.center))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        gameStart()
    }

    //個々のBeltに対して状態を反映させる
    private func configureUI(){
        zip(beltStates, beltViews).forEach {
            $1.configure(beltState: $0)

        }

        player1Buttons.enumerated().forEach { offset, UpDownButtonView in
            UpDownButtonView.configure(
                didTapUp: { [weak self] in
                    self?.itemUp(index: offset)
                },
                didTapDown: { [weak self] in
                    self?.itemDown(index: offset)
                }
            )}

        player2Buttons.enumerated().forEach { offset, UpDownButtonView in
            UpDownButtonView.configure(
                didTapUp: { [weak self] in
                    self?.itemUp(index: offset)
                },
                didTapDown: { [weak self] in
                    self?.itemDown(index: offset)
                }
            )}
    }

    // game開始(再開)
    private func gameStart() {

        beforeCountDown()
        // カウントダウン開始
        announceLabel.text = "③"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sounds.playSound(rosource: CountDown())

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.announceLabel.text = "②"

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.announceLabel.text = "①"

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.afterCountDown()

                    }
                }
            }
        }
    }

    // 画面初期化
    private func beforeCountDown() {

        announceLabel.isHidden = false

        // Btn有効化
        for button in player1Buttons {
            button.status(isEnabled: false)
        }

        for button in player2Buttons {
            button.status(isEnabled: false)
        }

        player1ScoreView.resetScore()
        player2ScoreView.resetScore()

    }

    // カウントダウン終了後の状態
    private func afterCountDown() {
        announceLabel.isHidden = true

        // Btn有効化
        for button in player1Buttons {
            button.status(isEnabled: true)
        }

        for button in player2Buttons {
            button.status(isEnabled: true)
        }

        // タイマースタート
        player1TimerView.timerStart()
        player2TimerView.timerStart()
    }

    private func itemUp(index: Int){

        let belt = beltStates[index]
        let item = belt.item
        let newItemPosition : ItemPosition = {
            switch belt.itemPosition{
                case let .onBelt(position):
                    return position.prev().map { ItemPosition.onBelt($0)} ?? ItemPosition.outOfBelt(.player1)
                case .outOfBelt:
                    return ItemPosition.onBelt(.center)
            }
        }()

        beltStates[index] = BeltState(item: item, itemPosition: newItemPosition)
        beltViews[index].configure(beltState: beltStates[index])
        checkIfOutOfBelt(index: index)
    }

    private func itemDown(index: Int){

        let belt = beltStates[index]
        let item = belt.item
        let newItemPosition : ItemPosition = {
            switch belt.itemPosition{
                case let .onBelt(position):
                    return position.next().map { ItemPosition.onBelt($0)} ?? ItemPosition.outOfBelt(.player2)
                case .outOfBelt:
                    return ItemPosition.onBelt(.center)
            }
        }()

        beltStates[index] = BeltState(item: item, itemPosition: newItemPosition)
        beltViews[index].configure(beltState: beltStates[index])
        checkIfOutOfBelt(index: index)
    }

    private func checkIfOutOfBelt(index: Int){
        switch beltStates[index].itemPosition {
            case let .outOfBelt(player):

                player1Buttons[index].status(isEnabled: false)
                player2Buttons[index].status(isEnabled: false)
                playSoundByTypeOfItem(item: beltStates[index].item)

                switch player {
                    case .player1:
                        player1ScoreView.updateScore(item: beltStates[index].item)
                    case .player2:
                        player2ScoreView.updateScore(item: beltStates[index].item)
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.resetBelt(index: index)
                }

            default:
                break
        }
    }

    private func resetBelt(index: Int){
        player1Buttons[index].status(isEnabled: true)
        player2Buttons[index].status(isEnabled: true)
        beltStates[index] = BeltState(item: randomItem(), itemPosition: .onBelt(.center))
        beltViews[index].configure(beltState: beltStates[index])
    }

    private func randomItem() -> ItemType {
        return MainViewController.itemArray.randomElement() ?? Apple()
    }

    // presentの種類によって音声を再生
    private func playSoundByTypeOfItem(item: ItemType) {
        // presentが爆弾なら爆発音、それ以外なら得点
        if item.isBomb {
            sounds.playSound(rosource: GetBomb())
        } else {
            sounds.playSound(rosource: GetPoint())
        }
    }

}
