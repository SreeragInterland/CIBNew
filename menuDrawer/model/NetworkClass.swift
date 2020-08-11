//
//  NetworkClass.swift
//  TAG
//
//  Created by Mac User on 24/03/20.
//  Copyright © 2020 Mac User. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClass{
    
    static var shared = NetworkClass()
    
    func headers() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        //        if let authToken = UserDefaults.standard.string(forKey: "auth_token") {
        //            headers["Authorization"] = "Token" + " " + authToken
        //        }
        return headers
    }
    
    func postDetailsToServerURL(withUrl strURL: String,withParam postParam: Dictionary<String, Any>,completion:@escaping (_ isSuccess: Bool, _ response:AFDataResponse<Any>) -> Void) {
        let url = Constants.baseURL+strURL
        print("url",url)
        AF.request(url, method: .post, parameters: postParam, encoding: URLEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success(let value):
                let json = value as? NSDictionary
                completion(true,response);
                
            case .failure(let error):
                completion(false,response)
                print(error)
            }
        }
    }
    func postDetailsToServerJSON(withUrl strURL: String,withParam postParam: Dictionary<String, Any>,completion:@escaping (_ isSuccess: Bool, _ response:AFDataResponse<Any>) -> Void) {
        let url = Constants.baseURL+strURL
        print("url",url)
        AF.request(url, method: .post, parameters: postParam, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success(let value):
                let json = value as? NSDictionary
                completion(true,response);
                
            case .failure(let error):
                completion(false,response)
                print(error)
            }
        }
    }
    func getDetailsFromServer(withUrl strURL: String,completion:@escaping (_ isSuccess: Bool, _ response:NSDictionary) -> Void) {
        let url = Constants.baseURL+strURL
        print("url",url)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success(let value):
                let json = value as? NSDictionary
                completion(true,json!);
                break
                
            case .failure(let error):
                completion(false,[:]);
                print(error)
            }
        }
    }
    
    func postDetailsToServerFormMethodWithImages(withUrl strURL: String,withHeader headerParam:HTTPHeaders,withImages imageDict:[UIImage],withParam postParam: Parameters,completion:@escaping (_ isSuccess: Bool, _ response:NSDictionary) -> Void) {
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
        let url = Constants.baseURL+strURL
        AF.upload(
            multipartFormData: { (multipartFormData) in
                for (key, value) in postParam {
//                    if let json = try? JSONSerialization.data(withJSONObject: value, options: []) {
//                        // here `json` is your JSON data
//                    }
                    if JSONSerialization.isValidJSONObject(value) {
                        let arrData = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        multipartFormData.append(arrData, withName: key as String)
                    } else {
                        if let json = try? JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed) {
                            if let content = String(data: json, encoding: String.Encoding.utf8) {
                                // here `content` is the JSON dictionary containing the String
                                print(content)
                                multipartFormData.append("\(value as! String)".data(using: .utf8)!, withName: key as String)
                            }
                        }
                    }
                }
                // To attach image with multipart
                for imageData in imageDict{
                    multipartFormData.append(imageData.jpegData(compressionQuality: 0.5)!, withName: "uploads[]", fileName: "file.jpeg", mimeType: "image/jpeg")
                }
        },to: url, method: .post  , headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { resp in
                switch resp.result{
                case .failure(let error):
                    print(error)
                    completion(false,[:]);
                case.success(let value):
                    print(value as Any)
                    let json = value as? NSDictionary
                    completion(true,json!);
                    print("🥶🥶Response after upload Img: \(resp.result)")
                }
        }
    }
    
    func putDetailsToServerForImageswithUrl(strURL: String,withParam postParam: Dictionary<String, Any>,completion:@escaping (_ isSuccess: Bool, _ response:NSDictionary) -> Void) {
        let url = Constants.baseURL+strURL
        print("url",url)
        AF.request(url, method: .put, parameters: postParam, encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success(let value):
                let json = value as? NSDictionary
                completion(true,json!);
                
            case .failure(let error):
                completion(false,[:])
                print(error)
            }
        }
    }
    
}
