//
//  ProjectDetailCommentTableViewCell.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/27.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

class ProjectDetailCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    

    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
