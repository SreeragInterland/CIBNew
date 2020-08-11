//
//  headerTableViewCell.swift
//  DBADemoApp
//
//  Created by mac on 03/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import DropDown
class headerTableViewCell: UITableViewCell {
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let dropDown = DropDown()
    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var but: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtFld.layer.borderColor = UIColor.lightGray.cgColor
        txtFld.layer.borderWidth = 1
        txtFld.layer.cornerRadius = 10
        txtFld.layer.masksToBounds = true
        let button = UIButton(type: .custom)
              button.setImage(UIImage(named: "dateDown"), for: .normal)
              button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
              button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
              self.txtFld.text = "Today"
//              button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
              txtFld.rightView = button
        dropDown.dataSource = ["today", "1254541245", "125454124545"]
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                 print("Selected item: \(item) at index: \(index)")
                   self.txtFld.text = item
               }
              txtFld.rightViewMode = .always
    }
    @IBAction func refresh(_ sender: Any) {
//        dropDown.show()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        txtFld.text = ""
    }
}
