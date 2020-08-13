//
//  moiTableViewCell.swift
//  menuDrawer
//
//  Created by mac on 12/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class moiTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleView.layer.cornerRadius = self.titleView.frame.height / 2
        self.titleView.clipsToBounds = true
        self.downView.layer.cornerRadius = self.downView.frame.height / 2
        self.downView.clipsToBounds = true
        self.mainView.layer.cornerRadius = 10
        self.mainView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
