//
//  ProfileImageTableViewCell.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/06/04.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {

 
    @IBOutlet weak var profileImageView: UIImageView!
    
 
    @IBOutlet weak var changeProfileImageButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
}

