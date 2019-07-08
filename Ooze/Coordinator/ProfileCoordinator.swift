//
//  ProfileCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/27.
//  Copyright © 2019 中原雄太. All rights reserved.
//


import UIKit

final class ProfileCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var profileViewController: ProfileViewController?
//    private var signInViewController: SignInViewController?
//    var profileDetailCoordinator: MovieDetailCoordinator?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
        
    }
    
    func start() {
//        let viewController = ProfileViewController()
        let viewController = ProfileViewController()
//        viewController.delegate = self
//        self.navigator.pushViewController(viewController, animated: true)
         self.navigator.pushViewController(viewController, animated: true)
//        self.editProfileViewController = viewController
        self.profileViewController = viewController
    }
}
//extension ProfileCoordinator: MovieListViewControllerDelegate {
//    func movieListViewControllerDidSelectContent(_ movie: MovieModel) {
//        let movieDetailCoordinator = MovieDetailCoordinator(navigator: self.navigator, model: movie)
//        movieDetailCoordinator.start()
//        self.movieDetailCoordinator = movieDetailCoordinator
//    }
//}

