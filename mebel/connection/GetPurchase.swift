//
//  GetPurchase.swift
//  mebel
//
//  Created by DS on 02.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class GetPurchase{
    
    var add:Bool = false;
    
    init(add:Bool){
        self.add = add;
        
        ViewController.typeMenu = TypeGridViewMenu.PURCHASE
        
        connect()
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseList
        
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        if add {
            let lastItem:PurchaseItem = ViewController.purchases[ViewController.purchases.count - 1]
            headers.add(name: "last",value: lastItem.id)
        } else {
            ViewController.purchases = [];
        }
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    do{
                        let newItems = try JSONDecoder().decode([PurchaseItem].self, from: response.data!)
                        ViewController.enableAddPurchase = newItems.count > 9
                        ViewController.purchases.append(contentsOf: newItems)
                        ViewController.gridView.reloadData()
                    } catch {
                        debugPrint(error)
                    }
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
        }
        
    }
    
}
