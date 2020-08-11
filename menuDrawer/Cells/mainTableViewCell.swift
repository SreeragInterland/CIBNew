//
//  mainTableViewCell.swift
//  DBADemoApp
//
//  Created by mac on 03/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var desc_label: UILabel!
    @IBOutlet weak var amount_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
