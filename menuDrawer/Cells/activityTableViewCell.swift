//
//  activityTableViewCell.swift
//  menuDrawer
//
//  Created by mac on 15/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class activityTableViewCell: UITableViewCell {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.circleView.layer.borderColor = UIColor.red.cgColor
         self.circleView.layer.borderWidth = 1
        self.circleView.layer.cornerRadius = self.circleView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
