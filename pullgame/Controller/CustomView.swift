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
    
    @IBOutlet var BtnActionDelegate : BtnAction?
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var upBtn0: UIButton!
    @IBOutlet weak var upBtn1: UIButton!
    @IBOutlet weak var upBtn2: UIButton!
    @IBOutlet weak var upBtn3: UIButton!
    @IBOutlet weak var upBtn4: UIButton!
    
    @IBOutlet weak var downBtn0: UIButton!
    @IBOutlet weak var downBtn1: UIButton!
    @IBOutlet weak var downBtn2: UIButton!
    @IBOutlet weak var downBtn3: UIButton!
    @IBOutlet weak var downBtn4: UIButton!
    
    @IBOutlet weak var BtnSV: UIStackView!
    
    @IBOutlet weak var winOrLoseLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        //CustomViewの部分は各自作成したXibの名前に書き換えてください
        let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func presetnUp(_ sender: Any) {
        
        let tag = ((sender as AnyObject).tag)!
        
        BtnActionDelegate?.didTapUp(tag)
        
    }
    
    @IBAction func presentDown(_ sender: Any) {
        
        let tag = ((sender as AnyObject).tag)!
        
        BtnActionDelegate?.didTapDown(tag)
        
    }
    
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
