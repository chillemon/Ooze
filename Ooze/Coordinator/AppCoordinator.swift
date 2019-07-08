//
//  AppCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/26.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import CoreSpotlight


final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UITabBarController
//    private let rootViewController: WelcomeViewController

    let launchType: LaunchType?

    private var movieListCoordinator: MovieListCoordinator
    private var myPageCoordinator: ProfileCoordinator
    private var makeContentsCoordinator: MakeContentsCoordinator

    enum LaunchType {
        case normal
        case notification(_ notification: UNNotificationRequest)
        case userActivity(NSUserActivity)
         case openURL(URL)
    }
    
    init(window: UIWindow, launchType: LaunchType? = nil) {
        self.window = window
        rootViewController = .init()
        self.launchType = launchType
//        let navigator = UINavigationController(rootViewController: self.welcomeViewController)
        let homeNavigationController = UINavigationController()
        let makeContentsNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()


        self.myPageCoordinator = ProfileCoordinator(navigator: profileNavigationController)
        self.makeContentsCoordinator = MakeContentsCoordinator(navigator: makeContentsNavigationController)
        self.movieListCoordinator = MovieListCoordinator(navigator: homeNavigationController)
      

        rootViewController.viewControllers = [homeNavigationController, makeContentsNavigationController, profileNavigationController]

    }
   
    func start() {
        window.rootViewController = rootViewController
        defer {
            window.makeKeyAndVisible()
        }
        
        guard let launchType = launchType else {

            myPageCoordinator.start()
            makeContentsCoordinator.start()
            movieListCoordinator.start()
        

            return
            
        }
        
        switch launchType {
        case .normal:
            break
        case .notification(let request):
            if request.trigger is UNPushNotificationTrigger {
                // remote notification
            } else if request.trigger is UNTimeIntervalNotificationTrigger {
                // local notification
            }
        case .userActivity(let userActivity):
            switch userActivity.activityType {
            case NSUserActivityTypeBrowsingWeb:
                break
                //universal links
            case CSSearchableItemActionType:
                break
                //Core Spotlight(incremental serach)
            case CSQueryContinuationActionType:
                break
                //Core Spotlight(incremental serach)
            default:
                fatalError("Unsearchable userActivity: '\(userActivity.activityType)'")
            }
        case .openURL(let url):
            if url.scheme == "coordinator-example-widget" {
                let identifier = url.lastPathComponent
            } else if url.scheme == "adjustSchemeExample" {
                //TODO: replace your adjust url scheme
            } else if url.scheme == "FirebaseDynamicLinksExample" {
                //TODO: handle your FDL
        }
    }
    }
        
}
