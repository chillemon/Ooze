//
//  ThanksForDonatingViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/24.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

protocol ThanksForDonationDelegate: AnyObject {
    func goToHome()
}


class ThanksForDonatingViewController: UIViewController {

    weak var delegate: ThanksForDonationDelegate?
    
    var thanksLabel: UILabel!
    var thanksImageView: UIImageView!
    var closeButton: UIButton!
    
    let srgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    // スクリーン画面のサイズを取得
    let screenWidth: CGFloat = UIScreen.main.bounds.width      //画面の幅
    let screenHeight: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupThanksView()
        setupCloseButton()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let visualEffectView = UIVisualEffectView(frame: view.frame)
        
        visualEffectView.effect = UIBlurEffect(style: .regular)
        view.insertSubview(visualEffectView, at: 0)

        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupThanksView() {
        // UIImage インスタンスの生成
        let image1:UIImage = UIImage(named:"thanksImage")!
    
        thanksImageView = UIImageView(image:image1)
        thanksImageView.frame = CGRect(x: 0, y: 0, width: screenWidth / 1.5, height: screenHeight / 3)
        thanksImageView.center = self.view.center
        thanksImageView.backgroundColor = .white
        
        self.view.addSubview(thanksImageView)
    }
    
    func setupCloseButton() {
        let closeImage: UIImage = UIImage(named: "icons8-キャンセル-50")!
        closeButton = UIButton()
        closeButton.layer.cornerRadius = 20
        closeButton.frame = CGRect(x: screenWidth / 7, y: screenHeight / 3.3, width: 40, height: 40)
        closeButton.backgroundColor = srgba
        closeButton.setImage(closeImage, for: .normal)
        closeButton.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
 
    @objc func closeButtonTapped(_ sender: UIButton) {
        //ホームに戻る
        //delegateできてない.つら
//         delegate?.goToHome()
       dismiss(animated: true, completion: nil)
        
       
    }

}

