//
//  payBillViewController.swift
//  menuDrawer
//
//  Created by mac on 13/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class payBillViewController: UIViewController {
    @IBOutlet weak var tab_bar: UITabBar!
    @IBOutlet weak var actDwnView: UIView!
    @IBOutlet weak var payDwnView: UIView!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var bills_table: UITableView!
    @IBOutlet weak var pay_table: UITableView!
    @IBOutlet weak var payeesView: UIView!
    @IBOutlet weak var payTbleHgtCnstrnt: NSLayoutConstraint!
    @IBOutlet weak var billsTbleHgtCnstrnt: NSLayoutConstraint!
    @IBOutlet weak var billsView: UIView!
    @IBOutlet weak var paysView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.payDwnView.isHidden = false
        self.actDwnView.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        bills_table.register(UINib(nibName: "billTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        pay_table.register(UINib(nibName: "payeesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
       
        setUpDesign()
    }
    func setUpDesign(){
        self.billsView.layer.cornerRadius = 10
        self.billsView.clipsToBounds = true
        self.paysView.layer.cornerRadius = 10
        self.paysView.clipsToBounds = true
        self.payeesView.layer.borderWidth = 1
        self.payeesView.layer.borderColor = UIColor(red: 89/255, green: 127/255, blue: 207/255, alpha: 1).cgColor
        self.payeesView.layer.cornerRadius = 5
        self.payeesView.clipsToBounds = true
        bills_table.reloadData()
               pay_table.reloadData()
    }
    override func viewWillLayoutSubviews() {
        self.payTbleHgtCnstrnt.constant = self.pay_table.contentSize.height
        self.billsTbleHgtCnstrnt.constant = self.bills_table.contentSize.height
    }
    @IBAction func menuBtnPrsd(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "drawer"), object: self)
    }
    @IBAction func payBtnPrsd(_ sender: UIButton) {
        bills_table.reloadData()
        self.payDwnView.isHidden = false
        self.actDwnView.isHidden = true
    }
    @IBAction func activityBtnPrsd(_ sender: UIButton) {
        self.payDwnView.isHidden = false
        self.actDwnView.isHidden = false
    }
    @IBAction func payeesBtnPrsd(_ sender: UIButton) {
    }
    
}
extension payBillViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bills_table{
        let cell:billTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! billTableViewCell
        return cell
        }else{
            let cell:payeesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! payeesTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if tableView == bills_table{
                   return 3
               }else{
                   return 3
               }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == bills_table{
            return 86
        }else{
            return 86
        }
    }
       
    
}
