//
//  GetSearch.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class GetSearch{
    
    var text:String = "";
    var add: Bool = false;
    var last:String!
    
    init(text:String, add:Bool) {
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.add = add;
        
        ViewController.typeMenu = TypeGridViewMenu.SEARCH
        
        connect()
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.searchList
        
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
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = self.text.data(using: .utf8)
        request.headers = headers;
        
        URLs.session.request(request).responseJSON{ response in
            
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
                        debugPrint(error)
                    }
                default:
                    debugPrint(response)
                }
            }
            
            NotificationCenter.default.post(name: Notification.Name("changeBack"), object: nil)
            
            ProgressBar.dismiss()
        }
    }
    
}
