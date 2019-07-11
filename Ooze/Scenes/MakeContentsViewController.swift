//
//  MakeContentsViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/06.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FloatingPanel




protocol MakeContetntsViewControllerDelegate: AnyObject {
    func makeContentsViewControllerDidTappedButton()
}

class MakeContentsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     var floatingPanelController: FloatingPanelController!
    
    
    weak var delegate: MakeContetntsViewControllerDelegate?
    
    let imagePickerController = UIImagePickerController()
    
    let storage = Storage.storage()
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let srgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    
    var authDataResult: AuthDataResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 匿名ログイン
        Auth.auth().signInAnonymously() { (authResult, error) in
            if (authResult?.user) != nil {
                self.authDataResult = authResult
            }
        }
        title = "作成"
        self.view.backgroundColor = .white
        
       
        setupAddMovieSquareButton()
        setupAddMovieCircleButton()
//        setupTitleOfContentsTextField()
        setupGoToSetAmountButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // セミモーダルビューを非表示にする
//        floatingPanelController.removePanelFromParent(animated: true)
    }
    
    func setupFloatingPanel() {
        floatingPanelController = FloatingPanelController()
        // Delegateを設定
        floatingPanelController.delegate = self
        floatingPanelController.surfaceView.cornerRadius = 24.0
      
//        self.view.backgroundColor = UIColor.gray
        
        // セミモーダルビューとなるViewControllerを生成し、contentViewControllerとしてセットする
        let semiModalViewController = SemiModalViewController()
        floatingPanelController.set(contentViewController: semiModalViewController)
        
        // セミモーダルビューを表示する
        floatingPanelController.addPanel(toParent: self, belowView: nil, animated: false)
        
        
    }
    
    
//    func setupTitleOfContentsTextField() {
//        let contentsTextField = UITextField()
//        contentsTextField.frame = CGRect(x: 20, y: self.view.frame.height / 2 - 50, width: self.view.frame.width - 40, height: 50)
//        contentsTextField.layer.borderColor = srgba.cgColor
//        contentsTextField.layer.borderWidth = 0.5
//        contentsTextField.placeholder = "タイトルを書いてみてちょ"
//
//        self.view.addSubview(contentsTextField)
//    }

    func setupAddMovieSquareButton() {
        let addMovieSquareButton = UIButton()
        addMovieSquareButton.frame = CGRect(x: self.view.frame.width / 2 - 140, y: self.view.frame.height / 2 - 200, width: 280, height: 150)
        addMovieSquareButton.center = view.center
        addMovieSquareButton.layer.borderWidth = 0.5
        addMovieSquareButton.layer.borderColor = srgba.cgColor
        addMovieSquareButton.layer.cornerRadius = 10.0
        addMovieSquareButton.setTitle("紹介動画を追加しよう", for: .normal)
        addMovieSquareButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        addMovieSquareButton.addTarget(self, action: #selector(self.didTapAddMovieButton(_:)), for: .touchUpInside)
        self.view.addSubview(addMovieSquareButton)
    }
    func setupAddMovieCircleButton() {
        let addMovieCircleButton = UIButton()
        addMovieCircleButton.frame = CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height / 2 + 45 , width: 100, height: 50)
        addMovieCircleButton.layer.cornerRadius = 20.0
        addMovieCircleButton.setImage(UIImage.init(named: "icons8-plus-50"), for: .normal)
        addMovieCircleButton.addTarget(self, action: #selector(self.didTapAddMovieButton(_:)), for: .touchUpInside)
        self.view.addSubview(addMovieCircleButton)
    }
    
    func setupGoToSetAmountButton() {
        let goToSetAmountButton = UIButton()
        goToSetAmountButton.frame = CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height / 2 + 200, width: 100, height: 50)
        goToSetAmountButton.setTitle("次へ", for: .normal)
        goToSetAmountButton.backgroundColor = srgba
        goToSetAmountButton.layer.cornerRadius = 10.0
        goToSetAmountButton.addTarget(self, action: #selector(self.didTapUpLoadButton(_:)), for: .touchUpInside)
        self.view.addSubview(goToSetAmountButton)
    }
    

    
    @objc func didTapUpLoadButton(_ sender: UIButton) {
        delegate?.makeContentsViewControllerDidTappedButton()
        
        setupFloatingPanel()
    
//        let vc = SemiModalViewController()
//        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func didTapAddMovieButton(_ sender: UIButton) {
    
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"] // 動画だけを取れるように
        navigationController?.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
        
        let fileName = "movie.MOV"
        
        let storageRef = storage.reference()
        let movieRef = storageRef.child("users").child("movie")
        let fileRef = movieRef.child(fileName)
        let uploadTask = fileRef.putFile(from: videoURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("error")
                return
            }
            print("成功")
    
        }
                imagePickerController.dismiss(animated: true, completion: nil)
    }
    
}

// FloatingPanelControllerDelegate を実装してカスタマイズしたレイアウトを返す
extension MakeContentsViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CustomFloatingPanelLayout()
    }
}
