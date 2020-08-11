//
//  fingerPrintViewController.swift
//  DBADemoApp
//
//  Created by mac on 20/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import LocalAuthentication
class fingerPrintViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var authImage: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var disabledBtn: UIButton!
    @IBOutlet weak var enabledBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func disabledBtnPrsd(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        enabledBtn.isSelected = !enabledBtn.isSelected
    }
    @IBAction func enabledBtnPrsd(_ sender: UIButton) {
         sender.isSelected = !sender.isSelected
        disabledBtn.isSelected = !disabledBtn.isSelected
    }
    
    func setupDesign(){
        self.okBtn.layer.cornerRadius = 10
        self.okBtn.layer.borderWidth = 1
        self.okBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func okBtnPrsd(_ sender: UIButton) {
        if(!self.disabledBtn.isSelected){
            /*
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
        self.navigationController?.pushViewController(vc, animated: true)*/
//            self.subView.isHidden = false
            biometric()
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
                  self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func cancelBtnPrsd(_ sender: UIButton) {
        self.subView.isHidden = true
    }
    func biometric(){
        let context = LAContext()
               var error: NSError?
        if #available(iOS 11.0, *) {
            if context.biometryType == .faceID{
                
            }
        } else {
            // Fallback on earlier versions
        }
               if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                   let reason = "Identify yourself!"

                   context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                       [weak self] success, authenticationError in

                       DispatchQueue.main.async {
                           if success {
                            let ac = UIAlertController(title: "", message: "You are verified", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (al) in
                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }))
                            self!.present(ac, animated: true)
                            
                           } else {
                               // error
                            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                self!.present(ac, animated: true)
                           }
                       }
                   }
               } else {
                   // no biometry
                    let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
               }
    }
}
