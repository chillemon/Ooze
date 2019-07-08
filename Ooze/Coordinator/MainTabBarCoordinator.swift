//
//  MainTabBarCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/02.
//  Copyright © 2019 中原雄太. All rights reserved.
//
//import Foundation
//import UIKit
//
//
//final class MainTabBarCoordinator: Coordinator {
//    
//    private let navigator: UINavigationController
//    var imagePicker: UIImagePickerController
//    private var mainTabBarController: MainTabBarController?
//    var makeMovieDetailCoordinator: MakeMovieDetailCoordinator?
//    
//    init(navigator: UINavigationController, imagePicker: UIImagePickerController) {
//        self.navigator = navigator
//        self.imagePicker = imagePicker
//    }
//    func start() {
//        let tabBarController = MainTabBarController()
//        tabBarController.tabDelegate = self
//        navigator.pushViewController(tabBarController, animated: true)
//        self.mainTabBarController = tabBarController
//    }
//}
//
//extension MainTabBarCoordinator: MainTabBarControllerDelegate {
//    func centerTabDidTap() {
//        let makeMovieDetailCoordinator = MakeMovieDetailCoordinator(navigator: self.navigator, imagePicker: self.imagePicker)
//        makeMovieDetailCoordinator.start()
//        self.makeMovieDetailCoordinator = makeMovieDetailCoordinator
//    }
//}
