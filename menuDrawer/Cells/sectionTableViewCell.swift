//
//  sectionTableViewCell.swift
//  CIB
//
//  Created by mac on 05/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class sectionTableViewCell: UITableViewCell {
    @IBOutlet weak var text_label:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
