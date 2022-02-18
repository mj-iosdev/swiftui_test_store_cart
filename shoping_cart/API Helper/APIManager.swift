//
//  APIManager.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import UIKit
import Alamofire

let ServiceManager = ApiManager.shared

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    
    
    private func callGET_POSTApi(reqMethod: HTTPMethod, url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (AFDataResponse<Any>?,Bool) -> Void){
                
        let headers: HTTPHeaders
        
        if headersRequired {
            headers = [
            "Content-Type":"application/json",
            "Accept": "application/json"
            ]
        } else {
            headers = [
            "Content-Type":"application/json",
            "Accept": "application/json"
            ]
        }
        
        let parameter = params
                        
        AF.request(url, method: reqMethod, parameters: parameter, headers: headers).responseJSON { (response) in
            switch response.result{
            case .success( _):
                completionHandler(response,true)
            case .failure( _):
                completionHandler(response,true)
            }
        }
    }
    
    func getAPICall(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (AFDataResponse<Any>?,Bool) -> Void){
            callGET_POSTApi(reqMethod: .get, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
    }
        
}
