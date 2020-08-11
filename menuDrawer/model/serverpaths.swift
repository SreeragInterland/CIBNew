//
//  serverpaths.swift
//  Alfaris International school
//
//  Created by mac on 05/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import Alamofire
class serverPath{
    static let shared = serverPath()
    public let API_BASEURL = "http://202.88.237.252/CibMobile/"
//    public let API_BASEURL = "http://192.168.1.16/CibMobile/"
    public let API_LOGIN = "user/login"
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
struct NetworkState {
    var isConnected: Bool {
        // isReachable checks for wwan, ethernet, and wifi, if
        // you only want 1 or 2 of these, the change the .isReachable
        // at the end to one of the other options.
        
        return NetworkReachabilityManager(host: "www.apple.com")!.isReachable
    }
}
