//
//  billDetailsViewController.swift
//  menuDrawer
//
//  Created by mac on 13/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class billDetailsViewController: UIViewController {

    @IBOutlet weak var cnfrmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.cnfrmBtn.layer.cornerRadius = 5
        self.cnfrmBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuBtnPrsd(_ sender: UIButton) {
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawer"), object: self)
      }


}

