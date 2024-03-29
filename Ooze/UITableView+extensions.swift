//
//  UITableView+extensions.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/04/26.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(cell: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil),
                      forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
