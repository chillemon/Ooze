//
//  ThanksMessageViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/15.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

class ThanksMessageViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    
    var thanksTextView: UITextView!
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let srgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    
    var thanksMessage: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "お礼の言葉")
        
        //ナビゲーションバー右のボタンを設定
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPushed(_:)))
        
        //ナビゲーションバー左のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        
        self.view.addSubview(navBar)
    
        setupThanksTextView()
      
       
    }
    
    func setupThanksTextView() {
        thanksTextView = UITextView()
        thanksTextView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 100, width: self.view.frame.width, height: 200)
        thanksTextView.text = "支援してくださりありがとうございます"
        
        thanksTextView.layer.borderWidth = 0.5
        thanksTextView.layer.borderColor = srgba.cgColor
        thanksTextView.keyboardType = .default
        thanksTextView.becomeFirstResponder()
        self.view.addSubview(thanksTextView)
    }
    
    
    
    // addBtnをタップしたときのアクション
    @objc func doneButtonPushed(_ sender: UIBarButtonItem) {
        guard let user = Auth.auth().currentUser else {
            // サインインしていない場合の処理をするなど
            return
        }
        let db = Firestore.firestore()
        let ref = db.collection("posts").document(user.uid)
        
   
        let message: String = thanksTextView.text ?? "応援ありがとうございます"
        
        thanksMessage?(String(message))
        self.dismiss(animated: true, completion: nil)
       
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
        
    }

}
