//
//  SetAmountViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/11.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit

class SetAmountViewController: UIViewController {
    
    var postDismissionAction: (() -> Void)?
    
    var moneyLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "目標金額")
        
        //ナビゲーションバー右のボタンを設定
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPushed(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        
        self.view.addSubview(navBar)
        setupAmountOfMoneyTextField()
        setupUploadButton()
    
    }
    
    @objc func doneButtonPushed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.postDismissionAction?()
        
    }

    func setupAmountOfMoneyTextField() {
        let amountOfMoneyTextField = UITextField()
        amountOfMoneyTextField.keyboardType = .numberPad
        amountOfMoneyTextField.frame = CGRect(x: 20, y: self.view.frame.height / 2 - 150, width: self.view.frame.width - 40, height: 50)
        amountOfMoneyTextField.placeholder = "必要な金額を入力"
        amountOfMoneyTextField.borderStyle = .roundedRect
        
        amountOfMoneyTextField.becomeFirstResponder()
      
 
        self.view.addSubview(amountOfMoneyTextField)
    }
    func setupUploadButton() {
        let upLoadButton = UIButton()
        upLoadButton.frame = CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height / 2 , width: 100, height: 50)

        upLoadButton.backgroundColor = .red
        upLoadButton.layer.cornerRadius = 10.0
        upLoadButton.addTarget(self, action: #selector(self.didTapFinishSettingButton(_:)), for: .touchUpInside)
        self.view.addSubview(upLoadButton)
    }

   
    
    @objc func didTapFinishSettingButton(_ sender: UIButton) {

        let thanksMessageViewController = ThanksMessageViewController()
        //次のページへ
        navigationController?.pushViewController(thanksMessageViewController, animated: true)
    }
}
