//
//  user.swift
//  Alfaris International school
//
//  Created by mac on 05/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
struct user:Codable {
    var customerId:String
    var fcmStatus:Bool
    var expiresIn:Int
    var refreshToken:String
    var lastLoginTime:String
    var scope:String
    var userName:String
    var profileImg:String
    var tokenType:String
    var accessToken:String
    var userId:String
    var status:String
    var accountNumber:[String]
    var message:String
    var userStatus:String
    var mPinStatus:Bool
    
}
