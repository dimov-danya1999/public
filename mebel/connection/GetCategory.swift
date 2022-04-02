//
//  GetCategory.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class GetCategory {
    
    var last:String = "";
    var add:Bool = false;
    
    init(add:Bool){
        
        self.add = add
        
        ViewController.typeMenu = TypeGridViewMenu.CATEGORY
        
        connect()

    }
    
    func connect() {
        
        ProgressBar.show();
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.categoriesChilds
        
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        if(add){
            let lastItem:ProductItem = ViewController.products[ViewController.products.count - 1]
            self.last = lastItem.id;
            headers.add(name: "last", value: last)
        } else {
            ViewController.products = [];
        }
        
        headers.add(name: "id", value: ViewController.idMenu)
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    do{
                        
                        let newItems = try JSONDecoder().decode([ProductItem].self, from: response.data!)
                        
                        ViewController.enableAdd = newItems.count > 9
                        ViewController.products.append(contentsOf:newItems);
                        ViewController.gridView.reloadData()
                        
                        ViewController.instance?.bannersScrollView.isHidden = true
                        
                    } catch {
                        DialogMessage.httpError(viewController: ViewController.context, data: response.data!)
                    }
                default:
                    debugPrint(response)
                }
            }
            
            NotificationCenter.default.post(name: Notification.Name("changeBack"), object: nil)
            
            ProgressBar.dismiss();
                        
        }
        
    }
    
    
}
