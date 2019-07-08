//
//  AVPlayerView.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/03.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

class AVPlayerView: UIView {

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
