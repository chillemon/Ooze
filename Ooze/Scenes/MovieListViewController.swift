//
//  MovieListViewController.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/26.
//  Copyright © 2019 中原雄太. All rights reserved.
//


import UIKit
import Firebase


protocol MovieListViewControllerDelegate: AnyObject {
    func movieListViewControllerDidSelectContent()
}

final class MovieListViewController: UIViewController {
    
    weak var delegate: MovieListViewControllerDelegate?
   
    let db = Firestore.firestore()
    let movieListCell = MovieListTableViewCell()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerNib(cell: MovieListTableViewCell.self)
        return tableView
    }()
    
    
    private var messageListener: ListenerRegistration?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    var movieList: [MovieModel] = [

        //ユーザーの投稿内容をFirebaseからとって表示
        
    ]
    
    var postsList:[String: Any]!
    
    // キャッシュ
    private var cellHeightList: [IndexPath: CGFloat] = [:]
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
 

        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "movieListCell")
        title = "ホーム"
        view.backgroundColor = .clear
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        tableView.rowHeight = 200
        
        
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (key, value) in postsList {
            print("\(key) -> \(value)")
        }
        guard let user = Auth.auth().currentUser else {
            // サインインしていない場合の処理をするなど
            return
        }
        
        db.collection("posts").getDocuments() {(querySnapshot, err) in
            if let error = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.postsList = document.data()
                }
            }
        }
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // 回転で高さが変わるのでキャッシュをクリア
        self.cellHeightList = [:]
    }
    
    //スクロール時にnavigationBarを隠す
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieList.count
        return postsList?.count ?? 30
        
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: MovieListTableViewCell.self, for: indexPath)
      
         return cell
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされた")
//        let movie = movieList[indexPath.row]
        delegate?.movieListViewControllerDidSelectContent()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

