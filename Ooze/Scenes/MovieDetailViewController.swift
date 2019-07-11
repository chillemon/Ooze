//
//  MovieDetailViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/26.
//  Copyright © 2019 中原雄太. All rights reserved.
//


import Foundation
import Firebase
import UIKit
import AVKit
import AVFoundation
import CoreMedia
//import Stripe

//protocol MovieDetailViewControllerDelegate: AnyObject {
//    func goToProjectDetail()
//}

class MovieDetailViewController: UIViewController   {
  
//    weak var delegate:  MovieDetailViewControllerDelegate?
    
    var movieURL: URL?
    // 再生用のアイテム.
    var playerItem : AVPlayerItem!
    
    // AVPlayer.
    var moviePlayer : AVPlayer!
    
    // シークバー.
    var seekBar : UISlider!
    
    let movieRef = Storage.storage().reference().child("movie/movie.MOV")
    
    override func viewWillAppear(_ animated: Bool) {
        downloadURL()
    }
    override func viewDidLoad() {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
    
        
        
        view.backgroundColor = .white
  
        
//        downloadURL()
     
    }
    
    func downloadURL() {
        let movieRef = Storage.storage().reference().child("movie/movie.MOV")
        movieRef.downloadURL { (unko, error) in
            guard let downloadURL = unko else {
                print("return")
                return
            }
            print("downloadURL : \(downloadURL)")
            let moviePlayer = AVPlayer(url: unko!)
             //レイヤーの追加
            let playerLayer = AVPlayerLayer(player: moviePlayer)
            playerLayer.frame = self.view.bounds
            playerLayer.backgroundColor = UIColor.lightGray.cgColor
            self.view.layer.addSublayer(playerLayer)
          
            // 再生
            moviePlayer.play()
        }
            // 動画が再生し終わったことを監視する設定
            NotificationCenter.default.addObserver(
                self, selector: #selector(self.endOfMovie(_:)),
                name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTakeScreenshot(notification:)),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func endOfMovie(_ sender: NotificationCenter) {
//        delegate?.goToProjectDetail()
        let projectDetailViewController = ProjectDetailViewController()
        self.navigationController?.present(projectDetailViewController, animated: true)
        
        
    }
    @objc func didTakeScreenshot(notification: Notification) {
        // 何かする
        print("こら！スクショするな！")
    }
        
        //サムネイル作成関数
//        func previewImageFromVideo(_ url:URL) -> UIImage? {
//
//            let movieRef = Storage.storage().reference().child("movie/movie.MOV")
//            movieRef.downloadURL { (unko, error) in
//                guard let downloadURL = unko else {
//                    print("return")
//                    return
//                }
//                print("downloadURL : \(downloadURL)")
//                let asset = AVAsset(url:unko!)
//                let imageGenerator = AVAssetImageGenerator(asset:asset)
//                imageGenerator.appliesPreferredTrackTransform = true
//
//                var time = asset.duration
//                time.value = min(time.value, 2)
//                do {
//                let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//                    return UIImage(cgImage: imageRef)
//
//                } catch {
//                    return nil
//                }
//
//            }
//    }
    
}

