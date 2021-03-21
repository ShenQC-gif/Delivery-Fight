//
//  ResultView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/21.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class ResultView: UIView {
    @IBOutlet private var resultLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("ResultView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }

    func configure(gameResult: GameResult) {
        resultLabel.text = gameResult.apperance().text
        resultLabel.textColor = gameResult.apperance().color
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
    var text: String { get }
    var color: UIColor { get }
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
