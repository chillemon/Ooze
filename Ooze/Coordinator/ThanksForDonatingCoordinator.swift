//
//  ThanksForDonatingCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/25.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class ThanksForDonatingCoordiantor: Coordinator {
    private let navigator: UINavigationController
    
    private var thanksForDonatingViewController: ThanksForDonatingViewController?
    var projectDetailCoordinator: ProjectDetailCoordinator?
    var movieListCoordinator: MovieListCoordinator?
    init(navigator: UINavigationController) {
        self.navigator = navigator
        
    }
    
    func start() {
        let viewController = ThanksForDonatingViewController()
        navigator.pushViewController(viewController, animated: true)
        self.thanksForDonatingViewController = viewController
        
    }
}

extension ThanksForDonatingCoordiantor: ThanksForDonationDelegate{
    
    func goToHome() {
        print("aaa")
        let movieListCoordinator = MovieListCoordinator(navigator: self.navigator)
        movieListCoordinator.start()
        self.movieListCoordinator = movieListCoordinator
    }
    
    
}
