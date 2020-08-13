//
//  statementTableViewCell.swift
//  CIB
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class statementTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
//    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var transLabel: UILabel!
    @IBOutlet weak var but: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainView.layer.cornerRadius = 10
        
        self.but.layer.cornerRadius = self.but.frame.height / 2
        self.but.layer.masksToBounds = true
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOffset = CGSize(width:0, height:0)
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
