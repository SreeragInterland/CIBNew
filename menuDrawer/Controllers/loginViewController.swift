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
   /*     self.corporateIdFld.attributedPlaceholder = NSAttributedString(string: "Corporate Id",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.userIdFld.attributedPlaceholder = NSAttributedString(string: "User Id",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.passwordFld.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let button4 = UIButton(type: .custom)
        button4.setImage(UIImage(named: "ic_lock_red_24dp"), for: .normal)
        button4.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button4.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            
        let container4 = UIView(frame: button4.frame)
        container4.backgroundColor = .clear
        container4.addSubview(button4)
        userIdFld.leftView = container4
        userIdFld.leftViewMode = .always
        
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "ic_lock_red_24dp"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button2.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
      
        let container = UIView(frame: button2.frame)
        container.backgroundColor = .clear
        container.addSubview(button2)
        passwordFld.leftView = container
        passwordFld.leftViewMode = .always
        
        let button3 = UIButton(type: .custom)
        button3.setImage(UIImage(named: "ic_corporate_logo_24dp"), for: .normal)
        button3.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button3.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        let container2 = UIView(frame: button3.frame)
        container2.backgroundColor = .clear
        container2.addSubview(button3)
        corporateIdFld.leftView = container2
        corporateIdFld.leftViewMode = .always
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "invisible"), for: .normal)
        button.setImage(UIImage(named: "visibility"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(self.refresh(but:)), for: .touchUpInside)
        let container3 = UIView(frame: button.frame)
        container3.backgroundColor = .clear
        container3.addSubview(button)
        passwordFld.rightView = container3
        passwordFld.rightViewMode = .always*/
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
