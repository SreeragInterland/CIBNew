//
//  chatTableViewCell.swift
//  Alfaris International school
//
//  Created by mac on 01/05/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class chatTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var msgStack: UIStackView!
    @IBOutlet weak var dateLabe: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var imgHgtCnstrnt: NSLayoutConstraint!
    @IBOutlet weak var imgWdthCnstrnt: NSLayoutConstraint!
    enum cellType {
        case outgoing
        case incoming
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.msgView.layer.cornerRadius = 10
        self.msgView.layer.masksToBounds = true
       // self.msgView.layer.borderWidth = 1
       // self.msgView.layer.borderColor = UIColor.lightGray.cgColor
        // Initialization code
    }
    func setUpCellType(type:cellType){
        if(type == .incoming){
            self.msgStack.alignment = .leading
            self.image_view.isHidden = false
            self.imgHgtCnstrnt.constant = 0
            self.imgWdthCnstrnt.constant = 0
            self.msgLabel.textColor = UIColor.black
            self.dateLabe.textColor = UIColor.black
            self.msgView.backgroundColor = UIColor.white
           // msgView.roundCorners(topLeft: 5, topRight: 10, bottomLeft: 10, bottomRight: 10)
        }else{
            self.msgStack.alignment = .trailing
            self.image_view.isHidden = true
            self.imgHgtCnstrnt.constant = 0
            self.imgWdthCnstrnt.constant = 0
            self.msgLabel.textColor = UIColor.white
            self.msgView.backgroundColor = UIColor.blue
            self.dateLabe.textColor = UIColor.white
            self.msgView.backgroundColor = UIColor(red: 146/255, green: 169/255, blue: 230/255, alpha: 1)
            // msgView.roundCorners(topLeft: 10, topRight: 5, bottomLeft: 10, bottomRight: 10)
        }
    }
    func hexStringToUIColor (hex:String,alpha:Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

