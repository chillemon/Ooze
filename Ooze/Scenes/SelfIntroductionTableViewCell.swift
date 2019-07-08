//
//  SelfIntroductionTableViewCell.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/02.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

class SelfIntroductionTableViewCell: UITableViewCell {

   
    @IBOutlet weak var selfIntroductionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
