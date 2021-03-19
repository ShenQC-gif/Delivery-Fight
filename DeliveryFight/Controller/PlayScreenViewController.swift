//
//  PlayScreenViewController.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/16.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class PlayScreenViewController: UIViewController {

    @IBOutlet private weak var conveyorView1: BeltView!
    @IBOutlet private weak var conveyorView2: BeltView!
    @IBOutlet private weak var conveyorView3: BeltView!
    @IBOutlet private weak var conveyorView4: BeltView!
    @IBOutlet private weak var conveyorView5: BeltView!

    @IBOutlet weak private var player1Buttons1: UpDownButtonView!
    @IBOutlet weak private var player1Buttons2: UpDownButtonView!
    @IBOutlet weak private var player1Buttons3: UpDownButtonView!
    @IBOutlet weak private var player1Buttons4: UpDownButtonView!
    @IBOutlet weak private var player1Buttons5: UpDownButtonView!


    @IBOutlet weak private var player2Buttons1: UpDownButtonView!
    @IBOutlet weak private var player2Buttons2: UpDownButtonView!
    @IBOutlet weak private var player2Buttons3: UpDownButtonView!
    @IBOutlet weak private var player2Buttons4: UpDownButtonView!
    @IBOutlet weak private var player2Buttons5: UpDownButtonView!


    private var beltViews : [BeltView] {
        [
            conveyorView1,
            conveyorView2,
            conveyorView3,
            conveyorView4,
            conveyorView5
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
    private var belts : [BeltState] = [
        BeltState(item: Apple(), itemPosition: .outOfBelt(Player.player1)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.pos1)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.pos2)),
        BeltState(item: Apple(), itemPosition: .onBelt(ItemBeltPosition.pos3)),
        BeltState(item: Apple(), itemPosition: .outOfBelt(Player.player2))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //個々のBeltに対して状態を反映させる
    private func configureUI(){
        zip(belts, beltViews).forEach {
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

    private func itemUp(index: Int){

        let belt = belts[index]
        let item = belt.item
        let newItemPosition : ItemPosition = {
            switch belt.itemPosition{
                case let .onBelt(position):
                    return position.prev().map { ItemPosition.onBelt($0)} ?? ItemPosition.outOfBelt(.player1)
                case .outOfBelt:
                    return ItemPosition.onBelt(.center)
            }
        }()

        belts[index] = BeltState(item: item, itemPosition: newItemPosition)
        beltViews[index].configure(beltState: belts[index])
    }

    private func itemDown(index: Int){

        let belt = belts[index]
        let item = belt.item
        let newItemPosition : ItemPosition = {
            switch belt.itemPosition{
                case let .onBelt(position):
                    return position.next().map { ItemPosition.onBelt($0)} ?? ItemPosition.outOfBelt(.player2)
                case .outOfBelt:
                    return ItemPosition.onBelt(.center)
            }
        }()

        belts[index] = BeltState(item: item, itemPosition: newItemPosition)
        beltViews[index].configure(beltState: belts[index])
    }



}
