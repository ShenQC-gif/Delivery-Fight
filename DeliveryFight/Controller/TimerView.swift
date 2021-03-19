//
//  TimerView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/19.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class TimerView: UIView {

    @IBOutlet private weak var timerLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("TimerView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)

    }

    func configure(time: TimeLimit){
        timerLabel.layer.cornerRadius = timerLabel.frame.size.width*0.2
        timerLabel.layer.borderWidth = 1
        setTime(time: time)
    }

    private func setTime(time: TimeLimit){
        timerLabel.text = "\(time.rawValue)"
    }


}
