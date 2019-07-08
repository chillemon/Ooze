//
//  SignInCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/24.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit


final class SignInCoordinator: Coordinator {
    
    private let navigator: UINavigationController
    private var signInViewController: SignInViewController?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let viewController = SignInViewController()
        self.navigator.pushViewController(viewController, animated: true)
        self.signInViewController = viewController
        
        
    }
}
