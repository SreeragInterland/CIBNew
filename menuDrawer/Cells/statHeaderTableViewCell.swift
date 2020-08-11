//
//  statHeaderTableViewCell.swift
//  CIB
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class statHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleView.layer.cornerRadius = self.titleView.frame.height / 2
        titleView.layer.shadowColor = UIColor.lightGray.cgColor
        titleView.layer.shadowOffset = CGSize(width: 1, height:2)
        titleView.layer.shadowOpacity = 0.6
        titleView.layer.shadowRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
