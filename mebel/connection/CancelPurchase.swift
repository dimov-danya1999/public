//
//  CancelPurchase.swift
//  mebel
//
//  Created by DS on 03.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class CancelPurchase{
    
    var id:String = "";
    var user:String = "";
    
    init(id:String, user:String) {
        ProgressBar.show()
        self.id = id;
        self.user = user;
        connect()
    }
    
    func connect(){
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseCancel

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "id", value: self.id)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
        
        URLs.session.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    debugPrint(response)
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
        }
        
    }

    
}
