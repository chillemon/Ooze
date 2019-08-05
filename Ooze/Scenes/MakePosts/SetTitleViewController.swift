//
//  SetTitleViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/17.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase


class SetTitleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    var postDismissionAction: (() -> Void)?
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let srgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)

    var titleOfContentsTextField: UITextField!
    var addThumbnailCircleButton: UIButton!
    
    var titleOfPost: ((String) -> Void)?
    
    let imagePickerController = UIImagePickerController()
    
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
        setupThumbnailButton()
        setupAddThumbnailCircleButton()
        self.view.addSubview(navBar)
        
        
        // Do any additional setup after loading the view.
    }
    @objc func doneButtonPushed(_ sender: UIBarButtonItem) {
      

        guard let user = Auth.auth().currentUser else {
            // サインインしていない場合の処理をするなど
            return
        }
        
        let titleText: String = titleOfContentsTextField.text ?? "TITLE"
        titleOfPost?(String(titleText) )
        self.dismiss(animated: true, completion: nil)
       

        
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupTitleOfContentsTextField() {
        titleOfContentsTextField = UITextField()
        titleOfContentsTextField.frame = CGRect(x: 20, y: self.view.frame.height / 3, width: self.view.frame.width - 40, height: 50)
        titleOfContentsTextField.layer.borderColor = srgba.cgColor
        titleOfContentsTextField.layer.borderWidth = 0.5
        titleOfContentsTextField.placeholder = "タイトルを書いてみてちょ"
        
        self.view.addSubview(titleOfContentsTextField)
    }
    
    func setupThumbnailButton() {
        let thumbnailButton = UIButton()
        thumbnailButton.frame = CGRect(x: self.view.frame.width / 8, y: self.view.frame.height / 2 , width: self.view.frame.width / 1.5, height: self.view.frame.height / 9.5)
        thumbnailButton.center = self.view.center
        thumbnailButton.backgroundColor = .clear
        thumbnailButton.layer.borderColor = srgba.cgColor
        thumbnailButton.layer.borderWidth = 1.0
        thumbnailButton.setTitle("動画のサムネイルを選択", for: .normal)
        thumbnailButton.setTitleColor(.black, for: .normal)
        thumbnailButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        thumbnailButton.addTarget(self, action: #selector(thumbnailButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(thumbnailButton)
        
    }
    
    func setupAddThumbnailCircleButton() {
        let addThumbnailCircleButton = UIButton()
        addThumbnailCircleButton.frame = CGRect(x: self.view.frame.width / 2.8, y: self.view.frame.height / 1.9 , width: 100, height: 50)
        addThumbnailCircleButton.layer.cornerRadius = 20.0
        addThumbnailCircleButton.setImage(UIImage.init(named: "icons8-plus-50"), for: .normal)
        addThumbnailCircleButton.addTarget(self, action: #selector(didTapAddThumbnailButton(_:)), for: .touchUpInside)
        self.view.addSubview(addThumbnailCircleButton)
    }
    
    @objc func thumbnailButtonTapped(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"] // 画像だけを取れるように
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func didTapAddThumbnailButton(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"] // 画像だけを取れるように
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }

        let fileName = "thumbnailImage.jpeg"
        let imageRef = Storage.storage().reference().child("image/thumbnail")
        let fileRef = imageRef.child(fileName)
        let uploadTask = fileRef.putFile(from: imageURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            print("成功")
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    

}
