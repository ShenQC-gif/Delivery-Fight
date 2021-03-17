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

    private var conveyorViews : [BeltView] {
        [
            conveyorView1,
            conveyorView2,
            conveyorView3,
            conveyorView4,
            conveyorView5
        ]
    }

    //ここで具体的なBeltの状態(Item,Item位置)を設定
    private var conveyors : [BeltState] = [
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
        zip(conveyors, conveyorViews).forEach {
            $1.configure(beltState: $0)

        }
    }
    


}
