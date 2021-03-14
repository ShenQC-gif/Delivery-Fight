//
//  CustomView.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/11/23.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

@objc protocol BtnAction {
    func didTapUp(_ tag: Int)

    func didTapDown(_ tag: Int)
}

class CustomView: UIView {
    @IBOutlet var BtnActionDelegate: BtnAction?

    @IBOutlet private var timerLabel: UILabel!
    @IBOutlet var BtnSV: UIStackView!
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!

    @IBOutlet var upBtn0: UIButton!
    @IBOutlet var upBtn1: UIButton!
    @IBOutlet var upBtn2: UIButton!
    @IBOutlet var upBtn3: UIButton!
    @IBOutlet var upBtn4: UIButton!

    @IBOutlet var downBtn0: UIButton!
    @IBOutlet var downBtn1: UIButton!
    @IBOutlet var downBtn2: UIButton!
    @IBOutlet var downBtn3: UIButton!
    @IBOutlet var downBtn4: UIButton!

    var scoreNum = Int()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func loadNib() {
        // CustomViewの部分は各自作成したXibの名前に書き換えてください
        let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        // timerに枠線を設定
        timerLabel.layer.borderWidth = 1
        scoreNum = 0
    }

    @IBAction func presetnUp(_ sender: Any) {
        let tag = ((sender as AnyObject).tag)!

        BtnActionDelegate?.didTapUp(tag)
    }

    @IBAction func presentDown(_ sender: Any) {
        let tag = ((sender as AnyObject).tag)!

        BtnActionDelegate?.didTapDown(tag)
    }

    func hideResultLabel(){
        resultLabel.isHidden = true
    }

    func configureApperance(gameResult: GameResult){

        resultLabel.isHidden = false

        let appearance = gameResult.apperance()
        resultLabel.text = appearance.text
        resultLabel.textColor = appearance.color
    }

    func updateScore(item: ItemType){
        scoreNum += item.score
        scoreLabel.text = "\(scoreNum)pt"
    }

    func resetScore(){
        scoreNum = 0
        scoreLabel.text = "0pt"
    }

    func loadTime(_ time: Int) {
        timerLabel.text = "\(time)"
    }

}

private extension GameResult {

    func apperance() -> GameResultAppearance {
        switch self {
        case .win:
            return WinAppearance()
        case .lose:
            return LoseAppearance()
        case .draw:
            return DrawAppearance()
        }
    }
}

protocol GameResultAppearance {
    var text : String{get}
    var color : UIColor{get}
}

struct WinAppearance: GameResultAppearance {
    var text: String = "Win!"
    var color: UIColor = .red
}

struct LoseAppearance: GameResultAppearance {
    var text: String = "...Lose"
    var color: UIColor = .blue
}


struct DrawAppearance: GameResultAppearance {
    var text: String = "Draw!"
    var color: UIColor = .black
}

