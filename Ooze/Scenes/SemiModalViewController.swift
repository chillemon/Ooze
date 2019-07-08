//
//  SemiModalViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/05/19.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import Foundation
import UIKit
import FloatingPanel
import Firebase

protocol SemiModalControllerDelegate: AnyObject {
    func SemiModalViewControllerDidSelectContent()
}

final class SemiModalViewController: UIViewController {

    weak var delegate: SemiModalControllerDelegate?

    var floatingPanelController: FloatingPanelController!
    
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let beforeSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:0.3)
    
    //タイトル・目標金額・お礼のメッセージの設定が終わったらこの色にする。
    let afterSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ホーム"
        view.backgroundColor = .clear
        view.addSubview(tableView)
        
        let navBar = UINavigationBar()
        navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        
        
        //ナビゲーションアイテムのタイトルを設定
        let navItem : UINavigationItem = UINavigationItem(title: "詳細")
        
        //ナビゲーションバー左のボタンを設定
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPushed(_:)))
        
        //ナビゲーションバーにアイテムを追加
        navBar.pushItem(navItem, animated: true)
        self.view.addSubview(navBar)
        
    
   
            tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    // モーダルを閉じる処理(キャンセルボタン）
    @objc func cancelButtonPushed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
}




extension SemiModalViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
      
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "タイトル"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.textLabel?.textAlignment = .center
            
        case 1:
            cell.textLabel?.text = "目標金額"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.textLabel?.textAlignment = .center
            
        case 2:
            cell.textLabel?.text = "お礼の言葉"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.textLabel?.textAlignment = .center
        case 3:
//            let customCell = tableView.dequeueReusableCell(withIdentifier: "shareButtonCell")
//            cell.textLabel?.text = "シェア"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            
//            cell.textLabel?.textAlignment = .center
            let shareButton = UIButton()
            shareButton.frame = CGRect(x: cell.frame.width / 2 - 10, y: 1, width: cell.frame.width / 3, height: 45)
            
            shareButton.backgroundColor = beforeSrgba
            shareButton.layer.cornerRadius = 10.0
            shareButton.setTitle("シェアする", for: .normal)
            cell.addSubview(shareButton)
            shareButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                shareButton.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5.0),
                shareButton.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                shareButton.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.6)
//                shareButton.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
////                shareButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
//                shareButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
                ])

            
      
            
        default:
            cell.textLabel?.textAlignment = .center
        }

        
        return cell
    }
    
    @objc func shareButtonPushed(_ sender: UIButton) {
    
    guard let user = Auth.auth().currentUser else {
    // サインインしていない場合の処理をするなど
    return
    }
        
        let db = Firestore.firestore()
        db.collection("contents").document(user.uid).setData([
            "Title" : String(),
            "TargetAmount": Int(),
            "ThanksMessage": String(),
            ]) { error in
                if let error = error {
                    //エラー処理
                    return
                }
                //成功した時の処理
        }
    }
    

}

extension SemiModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
            // セルの選択を解除
            tableView.deselectRow(at: indexPath, animated: true)
            
        switch indexPath.row {
        case 0:
            let setTitleViewController = SetTitleViewController()
            self.navigationController?.present(setTitleViewController, animated: true)
        case 1:
            let setAmountViewController = SetAmountViewController()
            self.navigationController?.present(setAmountViewController, animated: true)
        case 2:
            let thanksMessageViewController = ThanksMessageViewController()
            self.navigationController?.present(thanksMessageViewController, animated: true)
        default: break
            
        }

        
        delegate?.SemiModalViewControllerDidSelectContent()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
