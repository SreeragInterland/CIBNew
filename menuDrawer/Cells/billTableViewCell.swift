//
//  billTableViewCell.swift
//  menuDrawer
//
//  Created by mac on 13/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class billTableViewCell: UITableViewCell {
    
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
      @IBOutlet weak var amountLabel: UILabel!
      @IBOutlet weak var nameLabel: UILabel!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var titleView: UIView!
      @IBOutlet weak var btmLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleView.layer.cornerRadius = self.titleView.frame.height / 2
        self.titleView.clipsToBounds = true
        self.payBtn.layer.cornerRadius = self.payBtn.frame.height / 2
        self.payBtn.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
