//
//  menuViewController.swift
//  CIB
//
//  Created by mac on 04/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import Alamofire
class menuViewController: CommonViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var grouplabel: UILabel!
    @IBOutlet weak var myAccountlabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var table_view: UITableView!
     var sectionData2:[String] = [String]()
    var sectionData:[String] = [String]()
    var tableData:[[String]] = [[String]]()
    var imageArr:[String] = [String]()
    let k = serverPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
         self.table_view.register(UINib(nibName: "menuTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.table_view.register(UINib(nibName: "sectionTableViewCell", bundle: nil), forCellReuseIdentifier: "header")
        sectionData = ["SADAD Services","Payments","Account Services","Settings"]
        sectionData2 = ["SADAD Services","One Time Payment","Bill Payment","MOI Payment","MOI Refund","Payments","Account to Account","SARIE Payment","SWIFT Payment","Instant Payment","Account Services","My Account","Stop A Check","Deposit Inquiry","Loan Inquiry","Post Date Checks","Settings","My Profile","Notification Setup","Bio Metric Setup","Log Out"]
        imageArr = ["","ic_one_time_payment","ic_bill_payment","ic_moi_payment","refund","","account","ic_sarie_payment","ic_swift_payment","ic_instant_payment","","ic_my_accounts","ic_stop_a_check","ic_deposit_inquiry","ic_loan_inquiry","ic_post_date_check","","ic_my_profile","ic_notification_setup","ic_bio_metric_setup","ic_logout"]
        table_view.reloadData()
    
    }
    @IBAction func hmeBtnPrsd(_ sender: UIButton) {
       let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "change"), object: ["centre":centerViewController])
    }
    func logout(){
           self.showLoading()
           guard let accessToken:String = AppDefaults.shared.userDetails?.accessToken else{
               return
           }
           let authValue:String = "Bearer \(accessToken)"
           let header:HTTPHeaders = ["Authorization":authValue,"Accept":"application/json","Content-Type":"application/json"]
           k.ApiCall(params: Parameters(), header: header, url: Constants.baseURL+Constants.API_LOGOUT, method: .post) { (response) in
                self.hideLoading()
                   guard let errorCode:Int = response.response?.statusCode else{
                                                 return
                                             }
                              if (errorCode == 401) {
                                  let alert:UIAlertController = UIAlertController(title: "", message: "You must login first", preferredStyle: .alert)
                                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (al) in
                                      let vc:loginViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                                      let nv = UINavigationController(rootViewController: vc)
                                      UIApplication.shared.keyWindow?.rootViewController = nv
                                  }))
                                   self.present(alert, animated: true, completion: nil)
                              }else if (errorCode == 200){
                               let decoder = JSONDecoder()
                               do {
                               let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String:Any]
                               if let responseDic:[String:Any] = json as? [String:Any]{
                                      if let successstr:String = responseDic["result"] as? String{
                                          if(successstr == "Success"){
                                              //UserDefaults.standard.removeObject(forKey: "isSignIn")
                                             // UserDefaults.standard.removeObject(forKey: "User")
                                              let vc:loginViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                                              let nv = UINavigationController(rootViewController: vc)
                                              UIApplication.shared.keyWindow?.rootViewController = nv
                                          }else{
                                           //   UserDefaults.standard.removeObject(forKey: "isSignIn")
                                             // UserDefaults.standard.removeObject(forKey: "User")
                                              let vc:loginViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                                              let nv = UINavigationController(rootViewController: vc)
                                              UIApplication.shared.keyWindow?.rootViewController = nv
                                          }
                                      }else{
                                        //  UserDefaults.standard.removeObject(forKey: "isSignIn")//
                                          //UserDefaults.standard.removeObject(forKey: "User")
                                          let vc:loginViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                                          let nv = UINavigationController(rootViewController: vc)
                                          UIApplication.shared.keyWindow?.rootViewController = nv
                                      }
                                  }else{
                                     // UserDefaults.standard.removeObject(forKey: "isSignIn")
                                     // UserDefaults.standard.removeObject(forKey: "User")
                                      let vc:loginViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                                      let nv = UINavigationController(rootViewController: vc)
                                      UIApplication.shared.keyWindow?.rootViewController = nv
                                  }
                                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "remDrawerController"), object: self)
                               }catch{
                                   print(error)
                               }
                              }else{
                               self.view.makeToast(response.error?.localizedDescription)
                              }
                          }
       }
       
    func setUpDesign(){
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        self.profileImageView.layer.masksToBounds = true
    }

}
extension menuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(sectionData2[indexPath.row] == "SADAD Services" || sectionData2[indexPath.row] == "Payments" || sectionData2[indexPath.row] == "Account Services" || sectionData2[indexPath.row] == "Settings"){
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as! sectionTableViewCell
            headerCell.text_label.text = sectionData2[indexPath.row]
                return headerCell
        }else{
             let cell:menuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! menuTableViewCell
            if(sectionData2[indexPath.row] == "MOI Refund" || sectionData2[indexPath.row] == "Instant Payment" || sectionData2[indexPath.row] == "Post Date Checks" || sectionData2[indexPath.row] == "Log Out" || sectionData2[indexPath.row] == "Bio Metric Setup"){
                cell.downView.isHidden = true
            }else{
                 cell.downView.isHidden = false
            }
            if(sectionData2[indexPath.row] == "Log Out"){
                cell.btmView.isHidden = false
                cell.topView.isHidden = false
            }else{
                cell.btmView.isHidden = true
                cell.topView.isHidden = true
            }
            let strArr = sectionData2[indexPath.row]
            cell.text_label.text = strArr
            cell.image_view.image = UIImage(named:imageArr[indexPath.row])
            return cell
        }
    }
  /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let  headerCell = tableView.dequeueReusableCell(withIdentifier: "header") as! sectionTableViewCell
        headerCell.text_label.text = sectionData[section]
      return headerCell
      
    }*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData2.count
      //  return tableData[section].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if(sectionData2[indexPath.row] == "SADAD Services" || sectionData2[indexPath.row] == "Payments" || sectionData2[indexPath.row] == "Account Services" || sectionData2[indexPath.row] == "Settings" || sectionData2[indexPath.row] == "Log Out"){
                return 55
        }else{
                   
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(sectionData2[indexPath.row] == "Log Out"){
            self.logout()
        }else if(sectionData2[indexPath.row] == "MOI Payment"){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "sadadMoiViewController") as! sadadMoiViewController
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "change"), object: ["centre":centerViewController])
        }else if(sectionData2[indexPath.row] == "Bill Payment"){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "payBillViewController") as! payBillViewController
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "change"), object: ["centre":centerViewController])
        }else if(sectionData2[indexPath.row] == "MOI Refund"){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "billDetailsViewController") as! billDetailsViewController
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "change"), object: ["centre":centerViewController])
        }
         
    }
}
