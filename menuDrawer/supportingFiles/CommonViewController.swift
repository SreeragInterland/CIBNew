//
//  CommonViewController.swift
//  CIB
//
//  Created by mac on 02/08/20.
//  Copyright © 2020 Self. All rights reserved.
//
import UIKit

class CommonViewController: baseViewController {
    var activityInd:UIActivityIndicatorView!
    let smallView:UIView = UIView()
    let largeView:UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
             smallView.isHidden = true
             self.largeView.frame = self.view.frame
             smallView.frame = CGRect(x:self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2, width: 60, height: 60)
             smallView.center = self.view.center
             smallView.layer.cornerRadius = 12
             smallView.backgroundColor = UIColor.gray
              largeView.backgroundColor = UIColor.clear
             if (activityInd == nil) {
                 activityInd = UIActivityIndicatorView.init()
             }
             activityInd.frame = CGRect(x:0, y: 0, width: 60, height:60)
             activityInd.style = .whiteLarge
             smallView.addSubview(activityInd)
             self.largeView.addSubview(smallView)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
          largeView.frame = self.view.bounds
          smallView.frame = CGRect(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2, width: 60, height: 60)
          smallView.center = self.view.center
          activityInd.frame = CGRect(x:0, y: 0, width: 60, height:60)
      }
      func showLoading()  {
          self.view.addSubview(largeView)
          largeView.isHidden = false
          smallView.isHidden = false
          activityInd.isHidden = false
          activityInd.startAnimating()
      }

      func hideLoading()  {
          largeView.isHidden = true
          smallView.isHidden = true
          activityInd.isHidden = true
          activityInd.stopAnimating()
          largeView.removeFromSuperview()
      }
    func hexStringToUIColor (hex:String,alpha:Float) -> UIColor {
          var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
          
          if (cString.hasPrefix("#")) {
              cString.remove(at: cString.startIndex)
          }
          
          if ((cString.count) != 6) {
              return UIColor.gray
          }
          
          var rgbValue:UInt32 = 0
          Scanner(string: cString).scanHexInt32(&rgbValue)
          
          return UIColor(
              red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: CGFloat(alpha)
          )
      }

}
