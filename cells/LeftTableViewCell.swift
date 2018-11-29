//
//  LeftTableViewCell.swift
//  celatest1
//
//  Created by 徐勇 on 2018/10/24.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var weather3: UILabel!
    @IBOutlet weak var weather2: UILabel!
  
    @IBOutlet weak var date1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        weather3.adjustsFontSizeToFitWidth=true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
