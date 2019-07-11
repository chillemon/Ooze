//
//  ProjectDetailCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/10.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class ProjectDetailCoordinator: Coordinator {
    private let navigator: UINavigationController
    
    private var projectDetailViewController: ProjectDetailViewController?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
        
    }
    
    func start() {
        let viewController = ProjectDetailViewController()        
        self.navigator.present(viewController, animated: true)
        self.projectDetailViewController = viewController
        
    }
}


