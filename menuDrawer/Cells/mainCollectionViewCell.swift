//
//  mainCollectionViewCell.swift
//  DBADemoApp
//
//  Created by mac on 30/01/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class mainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        self.topView.layer.cornerRadius = 5
        self.topView.layer.masksToBounds = true
        super.awakeFromNib()
        // Initialization code
    }

}
