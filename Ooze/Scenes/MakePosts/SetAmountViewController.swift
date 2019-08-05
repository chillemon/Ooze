//
//  SetAmountViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/11.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SetAmountViewController: UIViewController {
    
    let db = Firestore.firestore()
    var descriptionLabel: UILabel!
    var postDismissionAction: (() -> Void)?
    var amountOfMoneyTextField: UITextField!
    var moneyLabel: UILabel?
    
    
    var amountOfMoney: ((Int) -> Void)?
    
    // スクリーン画面のサイズを取得
    let screenWidth: CGFloat = UIScreen.main.bounds.width      //画面の幅
    let screenHeight: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "目標金額")
        
        //ナビゲーションバー右のボタンを設定
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPushed(_:)))
        
        //ナビゲーションバー左のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        
        self.view.addSubview(navBar)
        setupAmountOfMoneyTextField()

    
    }
    
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: screenWidth / 8, y: screenHeight / 4, width: screenWidth / 2, height: screenHeight / 5)
        descriptionLabel.text = "数値だけで"
        self.view.addSubview(descriptionLabel)
    }
    
    func setupAmountOfMoneyTextField() {
        amountOfMoneyTextField = UITextField()
        amountOfMoneyTextField.keyboardType = .numberPad
        amountOfMoneyTextField.frame = CGRect(x: 20, y: self.view.frame.height / 2 - 150, width: self.view.frame.width - 40, height: 50)
        amountOfMoneyTextField.placeholder = "必要な金額を入力"
        amountOfMoneyTextField.borderStyle = .roundedRect
        
        amountOfMoneyTextField.becomeFirstResponder()
      
 
        self.view.addSubview(amountOfMoneyTextField)
    }
    
    @objc func doneButtonPushed(_ sender: UIButton) {

        guard let user = Auth.auth().currentUser else {
            // サインインしていない場合の処理をするなど
            return
        }
        let amount = amountOfMoneyTextField.text ?? "0"
        
        
        amountOfMoney?(Int(amount) ?? 0)
        self.dismiss(animated: true, completion: nil)
     
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }

    

   
    
    @objc func didTapFinishSettingButton(_ sender: UIButton) {

        let thanksMessageViewController = ThanksMessageViewController()
        //次のページへ
        navigationController?.pushViewController(thanksMessageViewController, animated: true)
    }
}
