//
//  SetTitleViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/17.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

class SetTitleViewController: UIViewController {
    
//    var postDismissionAction: (() -> Void)?
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let srgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "タイトル")

        //ナビゲーションバー右のボタンを設定
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPushed(_:)))

        //ナビゲーションバー左のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)

        view.backgroundColor = .white

        setupTitleOfContentsTextField()
        self.view.addSubview(navBar)
        
        
        // Do any additional setup after loading the view.
    }
    @objc func doneButtonPushed(_ sender: UIBarButtonItem) {
   
        self.dismiss(animated: true, completion: nil)
//        self.postDismissionAction?()
        //データベースにデータを送る
        //semiModal の”タイトル”セルを更新してチェックマークをつける(未実装）
        
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupTitleOfContentsTextField() {
        let contentsTextField = UITextField()
        contentsTextField.frame = CGRect(x: 20, y: self.view.frame.height / 2 - 50, width: self.view.frame.width - 40, height: 50)
        contentsTextField.layer.borderColor = srgba.cgColor
        contentsTextField.layer.borderWidth = 0.5
        contentsTextField.placeholder = "タイトルを書いてみてちょ"
        
        self.view.addSubview(contentsTextField)
    }
    

}
