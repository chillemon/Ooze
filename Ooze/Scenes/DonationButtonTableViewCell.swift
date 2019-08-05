//
//  DonationButtonTableViewCell.swift
//  Ooze
//
//  Created by 中原雄太 on 2019/07/13.
//  Copyright © 2019 中原雄太. All rights reserved.
//

import UIKit

protocol DonationButtonTableViewCellDelegate: AnyObject {
    func donationButtonTapped()
}
class DonationButtonTableViewCell: UITableViewCell {

    weak var delegate: DonationButtonTableViewCellDelegate?
    
    @IBOutlet weak var donationButton: UIButton!
    
    let navigator = UINavigationController()
 
    // e-sRGBA; red: 赤, green: 緑, blue: 青, a: 透明度
    let beforeSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:0.3)
    
    //タイトル・目標金額・お礼のメッセージの設定が終わったらこの色にする。
    let afterSrgba = UIColor(displayP3Red: 0.4, green: 0.5, blue: 0.8, alpha:1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        donationButton.setTitle("支払う", for: .normal)
        donationButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        donationButton.setTitleColor(.white, for: .normal)
        donationButton.backgroundColor = beforeSrgba
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func donationButtonTapped(_ sender: UIButton) {
        print("押されたンゴ")
        delegate?.donationButtonTapped()
//        thanksForDonatingViewController.modalPresentationStyle = .overCurrentContext

        
    }
}
