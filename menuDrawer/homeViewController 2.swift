//
//  homeViewController.swift
//  menuDrawer
//
//  Created by mac on 08/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
//import MMDrawerController
class homeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    @IBAction func menuBtnPrsd(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawer"), object: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
