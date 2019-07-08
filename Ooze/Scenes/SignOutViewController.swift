//
//  SignOutViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/30.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

class SignOutViewController: UIViewController {

    
    var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSignOutButton()
        // Do any additional setup after loading the view.
    }
    
    private func setupSignOutButton() {
        signOutButton = UIButton()
        signOutButton.frame = CGRect(x: 0, y: self.view.frame.height / 2, width: 50, height: 50)
        signOutButton.setTitle("サインアウト", for: .normal)
        self.view.addSubview(signOutButton)
    }
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        //エラーがなければ何もしない
        guard let error = errorOrNil else { return }
        
        let message = "エラーが起きました" //とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapSignOutButton() {
            do {
                try Auth.auth().signOut()
            } catch let error {
                showErrorIfNeeded(error)
            }
        }
    }
    




