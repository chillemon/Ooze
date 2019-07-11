//
//  BlackScreenView.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/12.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

class BlackScreenView: UIView {
    
    var redTextLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .black
        
        setupRedTextLabel()
    }
    
    func setupRedTextLabel() {
        redTextLabel = UILabel()
        redTextLabel.font = UIFont.systemFont(ofSize: 30)
        redTextLabel.text = "スクリーンショット不可"
        self.addSubview(redTextLabel)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
