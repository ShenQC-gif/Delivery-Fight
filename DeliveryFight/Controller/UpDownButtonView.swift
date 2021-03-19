//
//  UpDownButtonView.swift
//  DeliveryFight
//
//  Created by ちいつんしん on 2021/03/18.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import UIKit

final class UpDownButtonView: UIView {

    private var didTapUpHandler : () -> Void = {}
    private var didTapDownHandler : () -> Void = {}


    @IBOutlet private weak var upButton: UIButton!
    @IBOutlet private weak var downButton: UIButton!

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

    func configure(didTapUp: @escaping () -> Void, didTapDown: @escaping () -> Void){
        didTapUpHandler = didTapUp
        didTapDownHandler = didTapDown
    }

    func changeEnabled(){
        upButton.isEnabled.toggle()
        downButton.isEnabled.toggle()
    }

    @IBAction func didTapUp(_ sender: Any) {
        didTapUpHandler()
    }

    @IBAction func didTapDown(_ sender: Any) {
        didTapDownHandler()
    }



}
