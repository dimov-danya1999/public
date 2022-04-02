//
//  SetToken.swift
//  mebel
//
//  Created by Dima Chibuk on 7/25/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import Alamofire

class SetToken{
    
    var token:String!
    
    init(token:String) {
        self.token = token
        connect()
    }
       
    private func connect(){
        
        if ViewController.account == nil {
            return
        }
    
        let url:String = URLs.sayt + "/" + URLs.api + "/hs/ACCOUNT/TOKEN/"
        
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        headers.add(name:"id", value: ViewController.account.id)
        headers.add(name:"isIos", value: "true")
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = self.token.data(using: .utf8)
        request.headers = headers
                
        URLs.session.request(request).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    debugPrint(response)
                default:
                    DialogMessage.httpError(viewController: ViewController.context, data: response.data!)
                }
            }
            
        }
        
        
    }
    
}
