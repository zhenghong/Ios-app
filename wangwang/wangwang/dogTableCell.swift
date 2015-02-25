//
//  dogTableCell.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/22.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit


class dogTableCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var mes: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var flag: UIButton!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
