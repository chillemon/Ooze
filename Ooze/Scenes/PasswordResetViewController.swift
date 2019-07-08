//
//  PasswordResetViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/30.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

class PasswordResetViewController: UIViewController {
    
    var emailTextField: UITextField!
    var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmailTextField()
        setupSendButton()
       
    }
    
    private func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.frame = CGRect(x: self.view.frame.width / 3, y: self.view.frame.height / 2, width: self.view.frame.width / 2, height: 50)
        self.view.addSubview(emailTextField)
    }
    private func setupSendButton() {
        sendButton = UIButton()
        sendButton.frame = CGRect(x: self.view.frame.width / 3, y: self.view.frame.height / 2 + 100, width: 50, height: 50)
        self.view.addSubview(sendButton)
    }
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
    //エラーがなければ何もしない
    guard let error = errorOrNil else { return }
    
    let message = "エラーが起きました" //とりあえず固定文字列
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapSendButton() {
        let email = emailTextField.text ?? ""
        
        Auth.auth().sendPasswordReset(withEmail: email) { [ weak self ] error in
            guard let self = self else { return }
            if error != nil {
                //送信完了画面へ
            }
            self.showErrorIfNeeded(error)
        }        
    }
}
