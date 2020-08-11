//
//  AppDelegate.swift
//  menuDrawer
//
//  Created by mac on 08/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import MMDrawerController
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var nv:UINavigationController?
    var centerContainer: MMDrawerController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        IQKeyboardManager.shared.enable = true
        NotificationCenter.default.addObserver(self, selector: #selector(ToggleMenu), name: NSNotification.Name(rawValue: "drawer"), object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(remDrawerController), name: NSNotification.Name(rawValue: "remDrawerController"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(change(not:)), name: NSNotification.Name(rawValue: "change"), object: nil)
        if(UserDefaults.standard.value(forKey: "signIn") != nil){
            if(UserDefaults.standard.value(forKey: "signIn") as! Bool == true){
                if let data = UserDefaults.standard.value(forKey:"User") as? Data {
                   
                    AppDefaults.shared.userDetails = try? PropertyListDecoder().decode(user.self, from: data)
                    if let statusMpin = AppDefaults.shared.userDetails?.mPinStatus{
                        if statusMpin{
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                               let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                                               setUpMenu(centre: centerViewController)
                        }else{
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainStoryboard.instantiateViewController(withIdentifier: "newMpinViewController") as! newMpinViewController
                            nv = UINavigationController(rootViewController: vc)
                             self.window?.rootViewController = nv
                        }
                    }else{
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "newMpinViewController") as! newMpinViewController
                        nv = UINavigationController(rootViewController: vc)
                         self.window?.rootViewController = nv
                    }
                   
                }
            }
        }else{
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
            nv = UINavigationController(rootViewController: vc)
             self.window?.rootViewController = nv
        }
          
        return true
    }
     @objc func change(not:Notification){
        let vcDa:[String:Any] = not.object as! [String : Any]
        let vc:UIViewController = vcDa["centre"] as! UIViewController
        setUpMenu(centre: vc)
    }
    func setUpMenu(centre:UIViewController){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let leftViewController = mainStoryboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
                    let leftSideNav = UINavigationController(rootViewController: leftViewController)
                    let centerNav = UINavigationController(rootViewController: centre)
                    centerContainer = MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav)
//                    centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode. panningCenterView;
                    centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;
                    self.window?.rootViewController = centerContainer
    }
    @objc func ToggleMenu(){
        self.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    @objc func remDrawerController(){
        self.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
     //   self.navigationController?.popToViewController(self, animated: true)
    }

}

