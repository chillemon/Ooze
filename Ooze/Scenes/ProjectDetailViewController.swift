//
//  ProjectDetailViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/10.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit
import FloatingPanel
import Firebase

class ProjectDetailViewController: UIViewController {

    let db = Firestore.firestore()
    
    var sectionTitle: String = "コメント"
    var movieImageView: UIImageView!
    var playAgainButton: UIButton!
    var goToDonationButton: UIButton!
    
    var floatingPanelController: FloatingPanelController!
 
  
    let srgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    

    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerNib(cell: ProjectDetailCommentTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMovieImageView()
        setupPlayAgainButton()
        setupGoToDonationButton()

        
        title = "詳細"
        view.backgroundColor = .white
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: 60)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "詳細")
        
        //ナビゲーションバー右のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(cancelButtonPushed(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        
        self.view.addSubview(navBar)
        
        tableView.register(UINib(nibName: "ProjectDetailCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "projectDetailCommentCell")
        tableView.register(UINib(nibName: "CommentTextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "OpenCommentTextViewButtonCell")
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
//        tableView.rowHeight = 200
    }
    
    func setupMovieImageView() {
        movieImageView = UIImageView()
        movieImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 3)
        movieImageView.backgroundColor = UIColor.lightGray
        self.view.addSubview(movieImageView)
    }
    func setupPlayAgainButton() {
        playAgainButton = UIButton()
        playAgainButton.frame = CGRect(x: screenWidth / 9, y: screenHeight / 3 + 20, width: screenWidth / 3, height: 50)
        playAgainButton.layer.cornerRadius = 5.0
        playAgainButton.setTitle("もう一度再生", for: .normal)
        playAgainButton.setTitleColor(.black, for: .normal)
        
        playAgainButton.layer.borderColor = srgba.cgColor
        playAgainButton.layer.borderWidth = 1.0
        self.view.addSubview(playAgainButton)
    }
    
    func setupGoToDonationButton() {
        goToDonationButton = UIButton()
        goToDonationButton.frame =  CGRect(x: screenWidth / 1.8, y: screenHeight / 3 + 20, width: screenWidth / 3, height: 50)
        goToDonationButton.setTitle("支援する", for: .normal)
        goToDonationButton.layer.cornerRadius = 5.0
        goToDonationButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        goToDonationButton.setTitleColor(.white, for: .normal)
        goToDonationButton.backgroundColor = srgba
        goToDonationButton.addTarget(self, action: #selector(donationAction(_:)), for: .touchUpInside)
        self.view.addSubview(goToDonationButton)
    }
    
    
    @objc func cancelButtonPushed(_ sender: UIBarButtonItem) {
        print("バック")
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func donationAction(_ sender: UIButton) {
        floatingPanelController = FloatingPanelController()
        // Delegateを設定
        floatingPanelController.delegate = self
        floatingPanelController.surfaceView.cornerRadius = 24.0
        
        //        self.view.backgroundColor = UIColor.gray
        
        // セミモーダルビューとなるViewControllerを生成し、contentViewControllerとしてセットする
        let semiModalViewController = DonationSemiModalViewController()
        floatingPanelController.set(contentViewController: semiModalViewController)
        
        // セミモーダルビューを表示する
        floatingPanelController.addPanel(toParent: self, belowView: nil, animated: false)
        
    }

}
// FloatingPanelControllerDelegate を実装してカスタマイズしたレイアウトを返す
extension ProjectDetailViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CommentCustomFloatingPanelLayout()
    }
}

extension ProjectDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "コメント"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat(50)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return movieList.count
        return 30
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OpenCommentTextViewButtonCell", for: indexPath) as! CommentTextViewTableViewCell
            
            cell.openCommentTextViewButton.setTitle("コメントを書く", for: .normal)
            cell.openCommentTextViewButton.setTitleColor(srgba, for: .normal)
            cell.openCommentTextViewButton.addTarget(self, action: #selector(openCommentTextViewButtonTapped(_: )), for: .touchUpInside)
            return cell
            
        default:
            
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectDetailCommentCell", for: indexPath) as! ProjectDetailCommentTableViewCell
            
            
            return cell
            guard let user = Auth.auth().currentUser else {
                // サインインしていない場合の処理をするなど
                
            }
            
            let docRef = db.collection("posts").document(user.uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    
                    cell.commentLabel.text = dataDescription
                } else {
                    print("Document does not exists")
                }
            }
        
            
        }
    }
    
    @objc func openCommentTextViewButtonTapped(_ sender: UIButton) {
       
            floatingPanelController = FloatingPanelController()
            // Delegateを設定
            floatingPanelController.delegate = self
            floatingPanelController.surfaceView.cornerRadius = 24.0
            
            //        self.view.backgroundColor = UIColor.gray
            
            // セミモーダルビューとなるViewControllerを生成し、contentViewControllerとしてセットする
            let semiModalViewController = CommentSemiModalViewController()
            floatingPanelController.set(contentViewController: semiModalViewController)
            
            // セミモーダルビューを表示する
            floatingPanelController.addPanel(toParent: self, belowView: nil, animated: false)
            
            
        }
    
}

extension ProjectDetailViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされた")
        //        let movie = movieList[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


