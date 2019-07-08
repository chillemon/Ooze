//
//  WelcomeCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/24.
//  Copyright © 2019 中原雄太. All rights reserved.
//

//import Foundation
//import UIKit
//
//final class WelcomeCoordinator: Coordinator {
//    
//    let navigator: UINavigationController
//    var welcomeViewController: WelcomeViewController?
//    var signInCoordinator: SignInCoordinator?
//    
//    init(navigator: UINavigationController) {
//        self.navigator = navigator
//    }
//    func start() {
//        let viewController = WelcomeViewController()
//        viewController.delegate = self
//        navigator.pushViewController(viewController, animated: true)
//        self.welcomeViewController = viewController
//    }
//}
//
//extension WelcomeCoordinator: WelcomeViewControllerDelegate {
//    func welcomeViewControllerDidTapSignInButton() {
//        let signInCoordinator = SignInCoordinator(navigator: self.navigator)
//        signInCoordinator.start()
//        self.signInCoordinator = signInCoordinator
//    }
//}
