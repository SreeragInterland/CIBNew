//
//  newMpinViewController.swift
//  DBADemoApp
//
//  Created by mac on 20/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class newMpinViewController: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pinField: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    var activeTextField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupDesign()
    }
    func setupDesign(){
           self.pinField.attributedPlaceholder = NSAttributedString(string: "Corporate Id",
           attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
          
       }
    @IBAction func nextBtnPrsd(_ sender: UIButton) {
        self.titleLabel.text = "Confirm The MPin"
        self.nextBtn.setTitle("CONFIRM", for: .normal)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "fingerPrintViewController") as! fingerPrintViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
