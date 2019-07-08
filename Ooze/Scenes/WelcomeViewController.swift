//
//  WelcomeViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/24.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

protocol WelcomeViewControllerDelegate: AnyObject {
    func welcomeViewControllerDidTapSignInButton()
}

class WelcomeViewController: UIViewController {

    weak var delegate: WelcomeViewControllerDelegate?
    var signUpButton: UIButton!
    var signInButton: UIButton!
    var navigator: UINavigationController?
    
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let beforeSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:0.3)
    
    let afterSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSignInButton()
        setupSignUpButton()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSignUpButton() {
        
        signUpButton = UIButton()
        signUpButton.frame = CGRect(x: self.view.frame.width / 4, y: self.view.frame.height / 2 + 100, width: self.view.frame.width / 2, height: 50)
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.borderColor = UIColor.lightGray.cgColor
        signUpButton.setTitle("新規登録", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton(_:)), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
    }
    
    func setupSignInButton() {
        signInButton = UIButton()
        signInButton.frame = CGRect(x: self.view.frame.width / 4, y: self.view.frame.height / 2, width: self.view.frame.width / 2, height: 50)
        signInButton.backgroundColor = afterSrgba
        signInButton.layer.cornerRadius = 10.0
        signInButton.setTitle("ログイン", for: .normal)
        signInButton.addTarget(self, action: #selector(didTapSignInButton(_:)), for: .touchUpInside)
        self.view.addSubview(signInButton)
    }
    
    @objc func didTapSignUpButton(_ sender: UIButton) {
        print("タップされた")
        
    }
    
    @objc func didTapSignInButton(_ sender: UIButton) {
        print("タップされ座衛門")
        delegate?.welcomeViewControllerDidTapSignInButton()
        let signInViewController = SignInViewController()
        self.navigator?.pushViewController(signInViewController, animated: true)
    }

}


