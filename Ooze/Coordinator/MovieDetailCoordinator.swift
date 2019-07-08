//
//  MovieDetailCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/26.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailCoordinator: Coordinator {
    private let navigator: UINavigationController

    private var movieDetailViewController: MovieDetailViewController?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
      
    }
    
    func start() {
        let viewController = MovieDetailViewController()

        
        navigator.pushViewController(viewController, animated: true)
        self.movieDetailViewController = viewController
     
    }
}
