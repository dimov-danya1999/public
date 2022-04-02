//
//  ChangeSizePurchase.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class ChangeSizePurchase{
    
    var id:String;
    var product:String;
    var size:Int;
    
    init(id:String, product:String, size:Int){
        self.id = id;
        self.product = product;
        self.size = size;
        connect()
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseSize

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "id", value: self.id)
        headers.add(name: "product", value: self.product)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = self.size.description.data(using: .utf8)
        request.headers = headers;
                
        URLs.session.request(request).responseJSON{ response in
            
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
