//
//  MainTableViewCell.swift
//  celatest1
//
//  Created by 徐勇 on 2018/12/8.
//  Copyright © 2018 徐勇. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var weahterLabel1: UILabel!
    @IBOutlet weak var weahter1: UIImageView!
    @IBOutlet weak var temLabel: UILabel!
    @IBOutlet weak var temLabel2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
