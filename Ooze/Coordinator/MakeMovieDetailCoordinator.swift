//
//  MakeMovieDetailCoordinator.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/02.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

final class MakeMovieDetailCoordinator: Coordinator {

    weak var delegate: UIImagePickerControllerDelegate?
    private let navigator: UINavigationController
    
    var imagePicker: UIImagePickerController
    
    init(navigator: UINavigationController, imagePicker: UIImagePickerController) {
        self.navigator = navigator
        self.imagePicker = imagePicker
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickerController.mediaTypes = ["public.movie"] // 動画だけを取れるように
        navigator.pushViewController(imagePickerController, animated: true)
        self.imagePicker = imagePickerController
    }
}
