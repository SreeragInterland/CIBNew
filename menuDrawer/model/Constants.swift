//
//  Constants.swift
//  TAG
//
//  Created by Mac User on 28/02/20.
//  Copyright © 2020 Mac User. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class Constants {
    
    static let DEVICE_ID               = UIDevice.current.identifierForVendor!.uuidString
    
    static let SCREEN_WIDTH            = UIScreen.main.bounds.size.width
    
    static let SCREEN_HEIGHT           = UIScreen.main.bounds.size.height
    
    static let appDelegate             = UIApplication.shared.delegate as? AppDelegate
    
    static let baseURL                 = "http://202.88.237.252/CibMobile/"
    
    static let USERTOKEN               =  UserDefaults.standard.object(forKey:"access_token")!
    
    static let API_LOGIN               = "user/login"
    
    static let API_LOGOUT              = "user/logout"
    func ApiCall(params:Parameters,header:HTTPHeaders,url:String,method:HTTPMethod,completion:@escaping (AFDataResponse<Any>) -> ()) {
             AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response:AFDataResponse<Any>) in
                 switch(response.result) {
                 case .success(_):
                    completion(response)
                 case .failure(_):
                           completion(response)
                     break
                     
                 }
             }
         }
}
