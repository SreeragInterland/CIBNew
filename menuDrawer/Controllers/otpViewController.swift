//
//  otpViewController.swift
//  DBADemoApp
//
//  Created by mac on 12/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class otpViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var otpFld1: UITextField!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var otpFld2: UITextField!
        @IBOutlet weak var otpFld3: UITextField!
        @IBOutlet weak var otpFld4: UITextField!
        @IBOutlet weak var otpFld5: UITextField!
        @IBOutlet weak var otpFld6: UITextField!
    
      var activeTextField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    @IBAction func fingrBtnPrsd(_ sender: UIButton) {
    }
    @IBAction func signInBtnPrsd(_ sender: UIButton) {
    }
    
}
extension otpViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == self.otpFld6){
            let st1 = otpFld1.text! + otpFld2.text! + otpFld3.text!
            let st2 = otpFld4.text! + otpFld5.text! + otpFld6.text!
            let st = st1 + st2
            if st != "123456"{
                let vc:homeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "change"), object: ["centre":vc])
            }
        }else{
            textField.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.text!.count < 1  && string.count > 0{
            let nextTag = textField.tag + 1

            // get next responder
            var nextResponder = textField.superview?.viewWithTag(nextTag)

            if (nextResponder == nil){

                nextResponder = textField.superview?.viewWithTag(0)
            }
            textField.text = string
            nextResponder?.becomeFirstResponder()
            return false
        }
        else if textField.text!.count >= 1  && string.count == 0{
            // on deleting value from Textfield
            let previousTag = textField.tag - 1

            // get next responder
            var previousResponder = textField.superview?.viewWithTag(previousTag)

            if (previousResponder == nil){
                previousResponder = textField.superview?.viewWithTag(0)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        }
        return true

    }
}
