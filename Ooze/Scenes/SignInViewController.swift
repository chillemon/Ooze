//
//  SignInViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/29.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class SignInViewController: UIViewController {

    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var signInButton: UIButton!
    var signUpButton: UIButton!

    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let beforeSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:0.3)
    
    //タイトル・目標金額・お礼のメッセージの設定が終わったらこの色にする。
    let afterSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUpEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupSignUpButton()
       
    }
    
    func setupUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.frame = CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 4, width: self.view.frame.width / 2, height: 50)
        emailTextField.backgroundColor = beforeSrgba
        emailTextField.placeholder = "メールアドレス"
        self.view.addSubview(emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.frame = CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 3, width: self.view.frame.width / 2, height: 50)
        passwordTextField.backgroundColor = beforeSrgba
        passwordTextField.placeholder = "パスワード"
        self.view.addSubview(passwordTextField)
    }
    
    func setupSignUpButton() {
        signUpButton = UIButton()
        signUpButton.frame = CGRect(x: self.view.frame.width / 2 - 150, y: self.view.frame.height / 2, width: 150, height: 50)
        signUpButton.setTitle("サインアップ", for: .normal)
        signUpButton.setTitleColor(afterSrgba, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonDidTapped(_:)), for: .touchUpInside)
        self.view.addSubview(signUpButton)
    }
    
    @objc func signUpButtonDidTapped(_ sender: UIButton) {
        print("サインアップ画面へ遷移")
        let signUpviewController = SignUpViewController()
        self.navigationController?.present(signUpviewController, animated: true)
    }
    
    func setupSignInButton() {
        signInButton = UIButton()
        signInButton.frame = CGRect(x:  self.view.frame.width / 2 + 10, y:  self.view.frame.height / 2 , width: 150, height: 50)
        signInButton.setTitle("ログイン", for: .normal)
        signInButton.backgroundColor = afterSrgba
        signInButton.layer.shadowOpacity = 0.5
        signInButton.addTarget(self, action: #selector(signInButtonDidTapped(_:)), for: .touchUpInside)
        self.view.addSubview(signInButton)
    }
    
    @objc func signInButtonDidTapped(_ sender: UIButton) {
        print("タップ")
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                // サインイン後の画面へ
                let viewController = UITabBarController()
                self.navigationController?.present(viewController, animated: true)
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        //エラーがなければ何もしない
        guard let error = errorOrNil else { return }
        
        let message = errorMessage(of: error) //エラーメッセージ取得
        
        
    }
    
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errorCode = AuthErrorCode(rawValue: (error as NSError) .code) else {
            return message
        }
        
        switch errorCode {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
            
        default:
            break
        }
        
        return message
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
        
        
    


}
