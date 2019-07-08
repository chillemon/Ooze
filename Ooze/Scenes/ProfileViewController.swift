//
//  ProfileViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/27.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import Firebase

//
//    protocol ProfileViewControllerDelegate: AnyObject {
//        func ProfileViewControllerDidSelectRepo(_ item: MovieModel)
//    }



final class ProfileViewController: UIViewController {
    
    var editProfileButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).getDocument() { [weak self] snapshot, error in
            guard let self =  self else { return }
            
            if error != nil {
                //エラー処理
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists, let data = snapshot.data() else {
                //データがない時の処理
                return
            }
            
//            if let value = data[]
        }   }

//    weak var delegate: ProfileViewControllerDelegate?
    private var cellHeightList: [IndexPath: CGFloat] = [:]

//        weak var delegate: ProfileViewControllerDelegate?

        lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.frame = CGRect(x: 0, y: self.view.frame.height / 3, width: self.view.frame.width, height: self.view.frame.height / 1.5)
            tableView.backgroundColor = .white
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableView.automaticDimension
//            tableView.registerNib(cell: MovieListTableViewCell.self)
            return tableView
        }()

        init() {
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


        override func viewDidLoad() {
            super.viewDidLoad()

            title = "マイページ"
            view.backgroundColor = UIColor.lightGray
            view.addSubview(tableView)

            setupEditProfilebutton()
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
//
            
        }
    
    func setupEditProfilebutton() {
        editProfileButton = UIButton()
        editProfileButton.frame = CGRect(x: self.view.frame.width / 2, y: self.view.frame.height / 3, width: self.view.frame.width / 2, height: 50)
        editProfileButton.setTitle("プロフィール編集", for: .normal)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton(_:)), for: .touchUpInside)
        self.view.addSubview(editProfileButton)
    }
    
        private func showErrorIfNeeded(_ errorOrNil: Error?) {
        //エラーがなければ何もしない
        guard let error = errorOrNil else { return }
        
        let message = "エラーが起きました" //とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapEditProfileButton(_ sender: UIButton) {
        let editProfileViewController = EditProfileViewController()
        self.navigationController?.present(editProfileViewController, animated: true)
    }
    
        @objc func didTapWithdrawButton() {
        Auth.auth().currentUser?.delete() { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                // 非ログイン時の画面へ
            }
            self.showErrorIfNeeded(error)
        }
    }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        // 回転で高さが変わるのでキャッシュをクリア
//        self.cellHeightList = [:]
//    }

    }

    extension ProfileViewController: UITableViewDataSource {

        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
         
            //        cell.set[model: model]
            return cell
        }
    }

    extension ProfileViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let profile = movieList[indexPath.row]
//            delegate?.ProfileViewControllerDidSelectRepo(profile)
            tableView.deselectRow(at: indexPath, animated: true)
        }

//        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//            guard let height = self.cellHeightList[indexPath] else {
//                return UITableView.automaticDimension
//            }
//
//            return height
//        }

//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            if !self.cellHeightList.keys.contains(indexPath) {
//                //キャッシュする
//                self.cellHeightList[indexPath] = cell.frame.height
//            }
//
//
//        }
}

