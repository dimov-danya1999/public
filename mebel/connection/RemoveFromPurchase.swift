//
//  RemoveFromPurchase.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class RemoveFromPurchase{
    
    var id:String = "";
    var product:String = "";
    
    init(id:String, product:String) {
        self.id = id;
        self.product = product;
        
        connect()
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseRemove
       
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "id", value: self.id)
        headers.add(name: "product", value: self.product)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
        
        URLs.session.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    debugPrint("succes")
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
        }
    }
    
}
