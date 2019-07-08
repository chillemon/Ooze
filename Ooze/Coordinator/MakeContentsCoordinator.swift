//
//  MakeContentsCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/06.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class MakeContentsCoordinator: Coordinator {
   
    private let navigator: UINavigationController
    private var makeContentsViewController: MakeContentsViewController?
    var setAmountCoordinator: SetAmountCoordinator?
   
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let viewController = MakeContentsViewController()
//        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
        self.makeContentsViewController = viewController
    }
}

extension MakeContentsCoordinator: MakeContetntsViewControllerDelegate {
    func makeContentsViewControllerDidTappedButton() {
        let setAmountCoordinator = SetAmountCoordinator(navigator: self.navigator)
        setAmountCoordinator.start()
        self.setAmountCoordinator = setAmountCoordinator
    }
    
}



