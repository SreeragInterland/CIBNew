//
//  chatHeaderTableViewCell.swift
//  CIB
//
//  Created by mac on 08/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class chatHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = self.mainView.frame.height / 2
        self.mainView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
