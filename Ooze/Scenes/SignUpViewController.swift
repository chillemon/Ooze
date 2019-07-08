//
//  SignUpViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/27.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {

    
    var userNameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!

    var signUpButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()
        

        view.backgroundColor = .white
        
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "新規登録")
        
        //ナビゲーションバー右のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        
        self.view.addSubview(navBar)
        setupUserNameTextField()
        setupEmailTextField()
        setupEmailPasswordTextField()
        setupSignUpButton()

    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupUserNameTextField() {
        userNameTextField = UITextField()
        userNameTextField.frame = CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 5, width: self.view.frame.width / 2, height: 50)
        userNameTextField.placeholder = "ユーザー名"
        userNameTextField.backgroundColor = UIColor.lightGray
        self.view.addSubview(userNameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.frame = CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 3.7, width: self.view.frame.width / 2, height: 50)
        emailTextField.placeholder = "メールアドレス"
        emailTextField.backgroundColor = UIColor.lightGray
        self.view.addSubview(emailTextField)
    }
    
    func setupEmailPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.frame = CGRect(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 3, width: self.view.frame.width / 2, height: 50)
        passwordTextField.placeholder = "パスワード"
        passwordTextField.backgroundColor = UIColor.lightGray
        self.view.addSubview(passwordTextField)
    }
    
    func setupSignUpButton() {
        signUpButton = UIButton()
        signUpButton.frame = CGRect(x: self.view.frame.width / 3, y: self.view.frame.height / 2 + 100, width: self.view.frame.width / 3, height: 50)
        signUpButton.backgroundColor = UIColor.lightGray
        signUpButton.setTitle("サインアップ", for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        self.view.addSubview(signUpButton)
    }
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
        
        let message = errorMessage(of: error) // エラーメッセージを取得
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
            return message
        }
        
        switch errcd {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
        // 必要に応じて増減させてください
        default: break
        }
        return message
    }
    @objc func didTapSignUpButton(_ sender: UIButton) {
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        let name: String = userNameTextField.text ?? ""
        
        signUp(email: email, password: password, name: name)
    }
    
    private func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                self.updateDisplayName(name, of: user)
            }
            self.showErrorIfNeeded(error)
        }
    }

    private func updateDisplayName(_ name: String, of user: User) {
        let request = user.createProfileChangeRequest()
        request.displayName = name
        request.commitChanges() { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                self.sendEmailVerification(to: user)
            }
            self.showErrorIfNeeded(error)
        }
    }

    private func sendEmailVerification(to user: User) {
        user.sendEmailVerification() { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                self.showSignUpCompletion()
                //マイページに遷移
                let profileViewController = ProfileViewController()
                self.navigationController?.present(profileViewController, animated: true)
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    private func showSignUpCompletion() {
        // 完了したことを表示する
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}


