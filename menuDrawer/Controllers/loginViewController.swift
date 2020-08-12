//
//  loginViewController.swift
//  DBADemoApp
//
//  Created by mac on 11/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
class loginViewController: CommonViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var sprtBtn: UIButton!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var guideBtn: UIButton!
    @IBOutlet weak var brnchBtn: UIButton!
    @IBOutlet weak var supportImg: UIImageView!
    @IBOutlet weak var infoImg: UIImageView!
    @IBOutlet weak var guideImg: UIImageView!
    @IBOutlet weak var branchImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var userIdFld: UITextField!
    @IBOutlet weak var corporateIdFld: UITextField!
    @IBOutlet weak var scroll_view: UIScrollView!
    let rest = RestManager()
    let k = serverPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
//        UINavigationController.setNavigationBarHidden(tre)
        setupDesign()
        // Do any additional setup after loading the view.
    }
    func setupDesign(){
        self.brnchBtn.layer.cornerRadius = self.brnchBtn.frame.height / 2
        self.guideBtn.layer.cornerRadius = self.guideBtn.frame.height / 2
        self.infoBtn.layer.cornerRadius = self.infoBtn.frame.height / 2
        self.sprtBtn.layer.cornerRadius = self.sprtBtn.frame.height / 2
        self.brnchBtn.clipsToBounds = true
        self.guideBtn.clipsToBounds = true
        self.infoBtn.clipsToBounds = true
        self.sprtBtn.clipsToBounds = true
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.height / 2
        self.loginBtn.clipsToBounds = true
    }
    @objc func refresh(but:UIButton) {
//         dropDown.show()
        but.isSelected = !but.isSelected
        self.passwordFld.isSecureTextEntry = !self.passwordFld.isSecureTextEntry
        
     }
    @IBAction func loginBtnPrsd(_ sender: UIButton) {
         
    
        if(NetworkState().isConnected){
            login()
     /*       if(self.userIdFld.text!.count == 0){
//                login()
            }else if(self.passwordFld.text!.count == 0){
//                login()
            }else{
                login()
            }
 */
        }else{
          
        }
//        let vc:ViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func forgotBtnPrsd(_ sender: UIButton) {
        
    }
    
   
    
    
    
      func login(){
        self.showLoading()
        //let param:[String:Any] = ["password":self.passwordFld.text!,"userId":self.userIdFld.text!,"fcmToken":"fcm"]
        let urlStr:String = k.API_BASEURL + k.API_LOGIN
        let url = URL(string: urlStr)!
        let param:[String:String] = ["password":"123","userId":"s99000ios","fcmToken":"1fdrgtdrsgdfger"]
         let header:HTTPHeaders = ["Accept":"application/json","Content-Type":"application/json"]
  /*      k.ApiCall(params: param, header: header, url: urlStr, method: .post) { (response) in
            self.hideLoading()
            switch(response.result) {
           case .success(_):
                   let decoder = JSONDecoder()
                   do {
                        let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String:Any]
                        let posts = json?["status"] as? String
                        if(posts != "fail"){
                            let usera = try decoder.decode(user.self, from: response.data!)
                            print(usera)
                            UserDefaults.standard.set(true, forKey: "signIn")
                            UserDefaults.standard.synchronize()
                            UserDefaults.standard.set(try? PropertyListEncoder().encode(usera), forKey:"User")
                            if let data = UserDefaults.standard.value(forKey:"User") as? Data {
                                AppDefaults.shared.userDetails = try? PropertyListDecoder().decode(user.self, from: data)
                            }
                         /*   let vc:newMpinViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "newMpinViewController") as! newMpinViewController
                            self.navigationController?.pushViewController(vc, animated: true)*/
                        }else{
                            if let msg = json? ["message"] as? String{
                                self.view.makeToast(msg)
                            }
                        }
                    }catch{
                        print(error)
                    }
            case .failure(_):
                print(response.result)
                break
                                        
        }
     *//*
       rest.requestHttpHeaders.add(value: "application/x-www-form-urlencoded", forKey: "Content-Type")
        for (key,value) in param{
            rest.httpBodyParameters.add(value: value, forKey: key)
        }
         rest.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            self.hideLoading()
              if let _ = results.data, let response = results.response {
                if response.httpStatusCode == 200 {
                   let decoder = JSONDecoder()
                    do {
                        let json = try JSONSerialization.jsonObject(with: results.data!, options: .allowFragments) as? [String:Any]
                        let posts = json?["status"] as? String
                        
                        if(posts != "fail"){
                            
                            let usera = try decoder.decode(user.self, from: results.data!)
                            print(usera)
                            UserDefaults.standard.set(true, forKey: "signIn")
                            UserDefaults.standard.synchronize()
                            UserDefaults.standard.set(try? PropertyListEncoder().encode(usera), forKey:"User")
                            if let data = UserDefaults.standard.value(forKey:"User") as? Data {
                                AppDefaults.shared.userDetails = try? PropertyListDecoder().decode(user.self, from: data)
                            }
                            let vc:newMpinViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "newMpinViewController") as! newMpinViewController
                                                  self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            if let msg = json? ["message"] as? String{
                                self.view.makeToast(msg)
                            }
                        }
                        }catch{
                            print(error)
                        }
                      
                }else{
                            
                }
            }
        }*/
       NetworkClass.shared.postDetailsToServerURL(withUrl: Constants.API_LOGIN, withParam: param) { (success, response) in
                self.hideLoading()
             switch(success) {
                case true:
                       let decoder = JSONDecoder()
                       do {
                            let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [String:Any]
                            let posts = json?["status"] as? String
                            if(posts != "fail"){
                                let usera = try decoder.decode(user.self, from: response.data!)
                                print(usera)
                                UserDefaults.standard.set(true, forKey: "signIn")
                                UserDefaults.standard.synchronize()
                                UserDefaults.standard.set(try? PropertyListEncoder().encode(usera), forKey:"User")
                                if let data = UserDefaults.standard.value(forKey:"User") as? Data {
                                    AppDefaults.shared.userDetails = try? PropertyListDecoder().decode(user.self, from: data)
                                }
                                let vc:newMpinViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "newMpinViewController") as! newMpinViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }else{
                                if let msg = json? ["message"] as? String{
                                    self.view.makeToast(msg)
                                }
                            }
                        }catch{
                            print(error)
                        }
                case false:
                    print(response.result)
                    break
                                            
            }
        }
    }
}
