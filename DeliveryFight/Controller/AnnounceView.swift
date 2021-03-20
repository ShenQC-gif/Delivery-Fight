//
//  AnnounceView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/20.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

class AnnounceView: UIView {

    @IBOutlet private var announceLabel: UILabel!
    private var countDownStatus = CountDownStatus.startingStatus

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("AnnounceView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }

    func configure(gameStatus:GameStatus){
        switch gameStatus {
            case let .countDownBeforPlay(countDown):
                switch countDown {
                    case .three:
                        announceLabel.text = "③"
                    case .two:
                        announceLabel.text = "②"
                    case .one:
                        announceLabel.text = "①"
                }

            case .onPlay:
                announceLabel.isHidden = true

            case .afterPlay:
                announceLabel.isHidden = false
                announceLabel.text = "Finish!!"
        }
    }
}
