//
//  payeesTableViewCell.swift
//  menuDrawer
//
//  Created by mac on 13/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class payeesTableViewCell: UITableViewCell {

    @IBOutlet weak var radioBtn: UIButton!
      @IBOutlet weak var dateLabel: UILabel!
      @IBOutlet weak var amountLabel: UILabel!
      @IBOutlet weak var nameLabel: UILabel!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var titleView: UIView!
      @IBOutlet weak var btmLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.layer.cornerRadius = self.titleView.frame.height / 2
        self.titleView.clipsToBounds = true
        self.radioBtn.layer.cornerRadius = 5
        self.radioBtn.clipsToBounds = true
        self.radioBtn.layer.borderColor = UIColor.lightGray.cgColor
        self.radioBtn.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
