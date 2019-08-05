//
//  EditProfileViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/27.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

protocol EditProfileControllerDelegate: AnyObject {
    func editProfileDidSelectContent()
}

final class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let db = Firestore.firestore()
    
    let storage = Storage.storage()
    
    let imagePickerController = UIImagePickerController()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.registerNib(cell: <#T.Type#>)
        return tableView
    }()
    
    var nameTextField: UITextField!
    var selfIntroductionTextField: UITextField!
    var highSchoolNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "ProfileImageTableViewCell", bundle: nil), forCellReuseIdentifier: "changeProfileImageCell")
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "textFieldCell")
        tableView.register(UINib(nibName: "SelfIntroductionTableViewCell", bundle: nil), forCellReuseIdentifier: "selfIntroductionCell")
        
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "プロフィール編集")
        
        //ナビゲーションバー右のボタンを設定
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:)))
        
        //ナビゲーションバー左のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        
        view.backgroundColor = .white
        
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        

    }
  
    @objc func cancelAction(_ sender: UINavigationItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension EditProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
            
        case 0:
            let changeProfileImageCell = tableView.dequeueReusableCell(withIdentifier: "changeProfileImageCell", for:indexPath as IndexPath) as! ProfileImageTableViewCell
            
            changeProfileImageCell.changeProfileImageButton.setTitle("プロフィール画像を選択", for: .normal)
            
            changeProfileImageCell.profileImageView.layer.cornerRadius = 5.0
            changeProfileImageCell.changeProfileImageButton.addTarget(self, action: #selector(changeProfileImage), for: .touchUpInside)
            return changeProfileImageCell
        case 1:
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for:indexPath as IndexPath) as! TextFieldTableViewCell
            nameCell.textLabel?.text = "ニックネーム"
            nameCell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            
            nameCell.newNameTextField.borderStyle = .none
            return nameCell
            
        case 2:
            let selfIntroductionCell = tableView.dequeueReusableCell(withIdentifier: "selfIntroductionCell", for: indexPath as IndexPath) as! SelfIntroductionTableViewCell
            selfIntroductionCell.textLabel?.text = "自己紹介"
            selfIntroductionCell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
            
            return selfIntroductionCell
        case 3:
            let highSchoolNameCell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for:indexPath as IndexPath) as! TextFieldTableViewCell
            
            highSchoolNameCell.textLabel?.text = "高校名"
            highSchoolNameCell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            //現状のニックネームを取ってくる
           
            highSchoolNameCell.newNameTextField.borderStyle = .none
            return highSchoolNameCell
            
            
            
            
            
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    
    @objc func changeProfileImage(_ sender: UIButton) {
        print("はーお")
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"] // 画像だけを取れるように
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func doneAction(_ sender: UINavigationItem) {
        guard let user = Auth.auth().currentUser else {
            // サインインしていない場合の処理をするなど
            return
        }
        let ref = db.collection("users").document(user.uid)
//        let selfIntroduction = selfIntroductionTextField.text ?? "I am me！"
        let userName = nameTextField.text ?? "I am me"
        let highSchoolName = highSchoolNameTextField.text ?? "highSchool"
        
        ref.setData([
            
//            "introduction": selfIntroduction,
            "userName": userName,
            "highSchool": highSchoolName
            
            ])
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        
        let fileName = "image.jpeg"
        let imageRef = Storage.storage().reference().child("image")
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

extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        print("\(indexPath.row)行目のセルがタップされた")
        if let cell = tableView.cellForRow(at: indexPath) as? TextFieldTableViewCell {
            cell.newNameTextField.becomeFirstResponder()
            
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
//        delegate?.editProfileDidSelectContent()

    }
        
        
       
        
}
    

}
