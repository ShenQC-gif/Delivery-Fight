//
//  CustomView.swift
//  pullgame
//
//  Created by ちいつんしん on 2020/11/23.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

@objc protocol BtnAction {
    func didTapUp(_ index: Int)

    func didTapDown(_ index: Int)
}

class CustomView: UIView {
    weak var delegate: BtnAction?

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var BtnSV: UIStackView!
    @IBOutlet var resultLabel: UILabel!
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

    @IBAction func didTapUpButton0(_ sender: Any) {
        delegate?.didTapUp(0)
    }

    @IBAction func didTapUpButton1(_ sender: Any) {
        delegate?.didTapUp(1)
    }

    @IBAction func didTapUpButton2(_ sender: Any) {
        delegate?.didTapUp(2)
    }

    @IBAction func didTapUpButton3(_ sender: Any) {
        delegate?.didTapUp(3)
    }

    @IBAction func didTapUpButton4(_ sender: Any) {
        delegate?.didTapUp(4)
    }

    @IBAction func didTapDownButton0(_ sender: Any) {
        delegate?.didTapDown(0)
    }

    @IBAction func didTapDownButton1(_ sender: Any) {
        delegate?.didTapDown(1)
    }

    @IBAction func didTapDownButton2(_ sender: Any) {
        delegate?.didTapDown(2)
    }

    @IBAction func didTapDownButton3(_ sender: Any) {
        delegate?.didTapDown(3)
    }

    @IBAction func didTapDownButton4(_ sender: Any) {
        delegate?.didTapDown(4)
    }

    func configureResultUI(gameResult: GameResult) {
        resultLabel.isHidden = false

        let appearance = gameResult.appearance
        resultLabel.text = appearance.text
        resultLabel.textColor = appearance.color
    }
}

private extension GameResult {
    var appearance: ResultAppearance {
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

protocol ResultAppearance {
    var text: String { get }
    var color: UIColor { get }
}

struct WinAppearance: ResultAppearance {
    let text = "Win!"
    let color: UIColor  = .red
}

struct LoseAppearance: ResultAppearance {
    let text = "...Lose"
    let color: UIColor  = .blue
}

struct DrawAppearance: ResultAppearance {
    let text = "Draw!"
    let color: UIColor  = .black
}
