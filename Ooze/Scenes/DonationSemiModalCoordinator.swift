//
//  DonationSemiModalCoordinator.swift
//  
//
//  Created by 中原雄太 on 2019/07/25.
//

import Foundation
import UIKit

final class DonationSemiModalCoordinator: Coordinator {
    private let navigator: UINavigationController
    private var donationSemiModalViewController: DonationSemiModalViewController?
    var thanksForDonatingCoordinator: ThanksForDonatingCoordiantor?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    func start() {
        let viewController = DonationSemiModalViewController()
        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
        self.donationSemiModalViewController = viewController
    }
}

extension DonationSemiModalCoordinator: DonationSemiModalControllerDelegate {
    func donationSemiModalViewControllerDidSelectContent() {
        let thanksForDonatingCoordinator = ThanksForDonatingCoordiantor(navigator: self.navigator)
        thanksForDonatingCoordinator.start()
        self.thanksForDonatingCoordinator = thanksForDonatingCoordinator
    }
   
}
