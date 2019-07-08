//
//  MainTabBarController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/30.
//  Copyright © 2019 中原雄太. All rights reserved.
//
//
import UIKit
import Firebase

//protocol MainTabBarControllerDelegate: AnyObject {
//    func centerTabDidTap()
//}
//
//final class MainTabBarController: UITabBarController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    weak var tabDelegate: MainTabBarControllerDelegate?
//
//    let imagePickerController = UIImagePickerController()
//
//    private lazy var loadMovieButton: UIButton = {
//        let canterTabButton = UIButton()
//        canterTabButton.setBackgroundImage(UIImage(named: "icons8-plus-48"), for: .normal)
////        button.backgroundColor = UIColor.cyan
//
//        canterTabButton.sizeToFit()
////        button.addTarget(self, action: #selector(self.didTapLoadMovieButton(_:)), for: .touchUpInside)
//        self.tabBar.addSubview(canterTabButton)
//        return canterTabButton
//    }()
//
////    @objc func didTapLoadMovieButton(_ sender: UIButton) {
////        print("タップされたよ")
////        imagePickerController.sourceType = .photoLibrary
////        imagePickerController.delegate = self
////        imagePickerController.mediaTypes = ["public.movie"] // 動画だけを取れるように
//////        navigationController?.present(imagePickerController, animated: true, completion: nil)
////
////    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
//
//        let fileName = "movie.MOV"
//        let movieRef = Storage.storage().reference().child("movie")
//        let fileRef = movieRef.child(fileName)
//        let uploadTask = fileRef.putFile(from: videoURL, metadata: nil) { metadata, error in
//            guard let metadata = metadata else {
//                // Uh-oh, an error occurred!
//                return
//            }
//            print("成功")
//        }
//        imagePickerController.dismiss(animated: true, completion: nil)
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//
//    override func viewDidLayoutSubviews() {
//        loadMovieButton.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
//        loadMovieButton.center = CGPoint(x: tabBar.bounds.width / 2, y: tabBar.bounds.height - (loadMovieButton.bounds.height / 2))
//        loadMovieButton.layer.cornerRadius = loadMovieButton.bounds.width / 2
//        loadMovieButton.clipsToBounds = true
//
//    }
//  
//
//}
//
//extension MainTabBarController: MainTabBarControllerDelegate {
//
//    
//        func centerTabDidTap() {
//      
//            navigationController?.present(imagePickerController, animated: true, completion: nil)
//            
//            tabDelegate?.centerTabDidTap()
//    }
//
//}
