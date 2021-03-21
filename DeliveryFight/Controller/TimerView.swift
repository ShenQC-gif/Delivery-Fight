//
//  TimerView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/19.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class TimerView: UIView {
    @IBOutlet private var timerLabel: UILabel!
    private var timeLimitRepository = TimeLimitRepository()
    private var timeLimit = TimeLimit.thirty
    private var timer = Timer()
    private var restTime = Int()
    private var timeOverHandler : (() -> Void)? = {}

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

    func configure(timeOverHandler: (() -> Void)?) {
        timerLabel.layer.borderWidth = 1
        timeLimit = timeLimitRepository.load() ?? .thirty
        self.timeOverHandler = timeOverHandler
    }

    func setInitialTime(){
        restTime = timeLimit.rawValue
        setTime()
    }

    private func setTime() {
        timerLabel.text = "\(restTime)"
    }

    func timerStart() {
        // タイマーを作動
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] timer in

            if restTime > 0 {
                // 残り時間を減らしていく
                restTime -= 1
                setTime()
            }
            if restTime == 0 {
                // タイマーを無効化にし、ゲーム終了時の挙動へ
                timer.invalidate()
                timeOverHandler?()

            }
        })
    }
}
