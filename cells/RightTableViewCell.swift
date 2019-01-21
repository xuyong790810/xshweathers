//
//  RightTableViewCell.swift
//  celatest1
//
//  Created by 徐勇 on 2018/10/24.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {
    @IBOutlet weak var leftImageview: UIImageView!
    
    @IBOutlet weak var rightimageview: UIImageView!
    @IBOutlet weak var mylabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.rightimageview.isUserInteractionEnabled=true
        let tap=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        rightimageview.addGestureRecognizer(tap)
        // Initialization code
    }
    @objc func tapAction()
{
  
  helper.deleteCity(city: (self.mylabel?.text)!)
   NotificationCenter.default.post(name: NSNotification.Name(deleteCityNotification), object: nil)
}
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
 //   }
    
}
