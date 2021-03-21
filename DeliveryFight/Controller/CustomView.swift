//
//  CustomView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2020/11/23.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

protocol BtnAction: AnyObject {
    func didTapUp(button: CustomView.UpButton)

    func didTapDown(button: CustomView.DownButton)
}

class CustomView: UIView {
    weak var delegate: BtnAction?

    @IBOutlet private var timerLabel: UILabel!
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!

    @IBOutlet var BtnSV: UIStackView!

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

    enum UpButton{
        case upButton0
        case upButton1
        case upButton2
        case upButton3
        case upButton4
    }

    enum DownButton{
        case downButton0
        case downButton1
        case downButton2
        case downButton3
        case downButton4
    }

    var scoreNum = Int()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        // CustomViewの部分は各自作成したXibの名前に書き換えてください
        let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        // timerに枠線を設定
        timerLabel.layer.borderWidth = 1
        scoreNum = 0
    }


    @IBAction func didTapUpButton0(_ sender: Any) {
        delegate?.didTapUp(button:.upButton0)
    }

    @IBAction func didTapUpButton1(_ sender: Any) {
        delegate?.didTapUp(button:.upButton1)
    }

    @IBAction func didTapUpButton2(_ sender: Any) {
        delegate?.didTapUp(button:.upButton2)
    }

    @IBAction func didTapUpButton3(_ sender: Any) {
        delegate?.didTapUp(button:.upButton3)
    }

    @IBAction func didTapUpButton4(_ sender: Any) {
        delegate?.didTapUp(button:.upButton4)
    }

    @IBAction func didTapDownButton0(_ sender: Any) {
        delegate?.didTapDown(button:.downButton0)
    }

    @IBAction func didTapDownButton1(_ sender: Any) {
        delegate?.didTapDown(button:.downButton1)
    }

    @IBAction func didTapDownButton2(_ sender: Any) {
        delegate?.didTapDown(button:.downButton2)
    }

    @IBAction func didTapDownButton3(_ sender: Any) {
        delegate?.didTapDown(button:.downButton3)
    }

    @IBAction func didTapDownButton4(_ sender: Any) {
        delegate?.didTapDown(button:.downButton4)
    }


    func hideResultLabel(){
        resultLabel.isHidden = true
    }

    func configureApperance(gameResult: GameResult){

        resultLabel.isHidden = false

//        let appearance = gameResult.apperance()
//        resultLabel.text = appearance.text
//        resultLabel.textColor = appearance.color
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

//private extension GameResult {
//
//    func apperance() -> GameResultAppearance {
//        switch self {
//        case .win:
//            return WinAppearance()
//        case .lose:
//            return LoseAppearance()
//        case .draw:
//            return DrawAppearance()
//        }
//    }
//}
//
//protocol GameResultAppearance {
//    var text : String{get}
//    var color : UIColor{get}
//}
//
//struct WinAppearance: GameResultAppearance {
//    var text: String = "Win!"
//    var color: UIColor = .red
//}
//
//struct LoseAppearance: GameResultAppearance {
//    var text: String = "...Lose"
//    var color: UIColor = .blue
//}
//
//
//struct DrawAppearance: GameResultAppearance {
//    var text: String = "Draw!"
//    var color: UIColor = .black
//}

