//
//  BeltView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/17.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit
import Foundation

//渡されたBeltのitemPoistionに従ってitem画像を表示
final class BeltView: UIView {

    @IBOutlet private weak var fruitImageView0: UIImageView!
    @IBOutlet private weak var fruitImageView1: UIImageView!
    @IBOutlet private weak var fruitImageView2: UIImageView!
    @IBOutlet private weak var fruitImageView3: UIImageView!
    @IBOutlet private weak var fruitImageView4: UIImageView!
    @IBOutlet private weak var fruitImageView5: UIImageView!
    @IBOutlet private weak var fruitImageView6: UIImageView!

    private var fruitImageViews : [UIImageView] {
        [
            fruitImageView0,
            fruitImageView1,
            fruitImageView2,
            fruitImageView3,
            fruitImageView4,
            fruitImageView5,
            fruitImageView6
        ]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func clearImage(){
        fruitImageViews.forEach {
            $0.image = nil
        }
    }

    private func loadNib() {

        let view = Bundle.main.loadNibNamed("BeltView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)

        clearImage()

    }

    //渡されたbeltのitemPoistionにitem画像を反映させる
    func configure(beltState:BeltState){
        clearImage()

        func targetImageView() -> UIImageView{

            switch beltState.itemPosition {
                case let .onBelt(poistion):
                    switch poistion {
                        case .pos0:
                            return fruitImageViews[1]
                        case .pos1:
                            return fruitImageViews[2]
                        case .pos2:
                            return fruitImageViews[3]
                        case .pos3:
                            return fruitImageViews[4]
                        case .pos4:
                            return fruitImageViews[5]
                    }

                case let .outOfBelt(player):
                    switch player {

                        case .player1:
                            return fruitImageViews[0]
                        case .player2:
                            return fruitImageViews[6]
                    }
            }
        }

        targetImageView().image = UIImage(named:  beltState.item.imageName)
    }

    func hideItem(hide: Bool){
        for imageView in fruitImageViews{
            imageView.isHidden = hide
        }
    }

    private func setRandomItem() -> ItemType{
        return MainViewController.itemArray.randomElement() ?? Apple()
    }
}
