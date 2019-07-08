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

class MovieDetailViewController: UIViewController {
  
    
    var movieURL: URL?
    // 再生用のアイテム.
    var playerItem : AVPlayerItem!
    
    // AVPlayer.
    var videoPlayer : AVPlayer!
    
    // シークバー.
    var seekBar : UISlider!
    
  
    
    
    override func viewDidLoad() {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
    
        let movieRef = storageRef.child("movie/movie.MOV")
        movieRef.downloadURL { (url, error) in
            print("downloadURL")
            guard let downloadURL = url else {
                print("return")
                return
            }
            print("downloadURL : \(downloadURL)")
           
        }
        view.backgroundColor = .white
        title = "詳細"
      
        // 動画ファイルのURLを取得
        let url = URL(string: "url")
        
        // 生成
        let player = AVPlayer(url: url!)
        
        // レイヤーの追加
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.backgroundColor = UIColor.lightGray.cgColor
        self.view.layer.addSublayer(playerLayer)
        
        // 再生
        player.play()
    }
    
}
