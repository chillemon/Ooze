//
//  MovieListCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/26.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class MovieListCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var movieListViewController: MovieListViewController?
    var movieDetailCoordinator: MovieDetailCoordinator?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    func start() {
        let viewController = MovieListViewController()
        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
        self.movieListViewController = viewController
    }
}

extension MovieListCoordinator: MovieListViewControllerDelegate {
    func movieListViewControllerDidSelectContent() {
        let movieDetailCoordinator = MovieDetailCoordinator(navigator: self.navigator)
        movieDetailCoordinator.start()
        self.movieDetailCoordinator = movieDetailCoordinator
    }
}
