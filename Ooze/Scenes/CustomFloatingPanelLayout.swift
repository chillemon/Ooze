//
//  CustomFloatingPanelLayout.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/23.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import FloatingPanel
import UIKit

class CustomFloatingPanelLayout: FloatingPanelLayout {
   
    //セミモーダルの初期位置
    var initialPosition: FloatingPanelPosition {
        return .half
    }
    
    var topInteractionBuffer: CGFloat { return 0.0 }
    var bottomInteractionBuffer: CGFloat { return 0.0 }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 56.0
        case .half: return 262.0
        case .tip: return 100.0
        case .hidden: return 0
            
        }
        
    }
    
    // セミモーダルビューの背景Viewの透明度
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.5
    }
    
}
