//
//  TextFieldTableViewCell.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/01.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var newNameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
