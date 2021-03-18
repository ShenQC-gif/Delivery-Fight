//
//  UpDownButtonView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/18.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

final class UpDownButtonView: UIView {

    @IBOutlet private weak var UpButtonView: UIButton!
    @IBOutlet private weak var DownButtonView: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    private func loadNib() {

        let view = Bundle.main.loadNibNamed("UpDownButtonView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)

    }

    @IBAction func didTapUp(_ sender: Any) {

    }

    @IBAction func didTapDown(_ sender: Any) {
    }



}
