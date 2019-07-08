//
//  SetAmountCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/13.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class SetAmountCoordinator: Coordinator {
   
    
    private let navigator: UINavigationController
    private var setAmountViewController: SetAmountViewController?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator

    }
    
    func start() {
        let viewController = SetAmountViewController()
        
        self.navigator.pushViewController(viewController, animated: true)
        self.setAmountViewController = viewController
        
    }
    
    
}
