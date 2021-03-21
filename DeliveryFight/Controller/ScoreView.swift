//
//  ScoreView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/20.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    @IBOutlet private var scoreLabel: UILabel!

    // PlayScreenVCで得点比較するためprivateではない
    var score = Score()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("ScoreView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        scoreLabel.text = "\(score.score) pt"
    }

    func updateScore(item: ItemType) {
        score.updateScore(item: item)
        scoreLabel.text = "\(score.score) pt"
    }

    func resetScore() {
        score.resetScore()
        scoreLabel.text = "\(score.score) pt"
    }
}
