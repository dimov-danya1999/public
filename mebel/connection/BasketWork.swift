//
//  BasketWork.swift
//  mebel
//
//  Created by DS on 06.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class BasketWork{
    
    public func create(comment:String!){
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseCreate

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
                        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = headers;
        if(comment != nil){
            request.httpBody = comment.data(using: .utf8)
        }
        
        URLs.session.request(request).responseString{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if(BasketActivity.tableView != nil){
                        BasketActivity.tableView.reloadData()
                    }
                    DialogMessage.infoTopData(data: response.data!)
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
        }
    }
    
    public func cancel(product:String){
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.basketCancel

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "product", value: product)
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
                
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = headers;
                
        URLs.session.request(request).responseString{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if(BasketActivity.tableView != nil){ BasketActivity.tableView.reloadData()
                    }
                    DialogMessage.infoTopData(data: response.data!)
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
        }
    }
    
    public func add(product:String, size:Int) {
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.basketAdd

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "product", value: product)
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
                
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = size.description.data(using: .utf8)
        request.headers = headers;
                
        URLs.session.request(request).responseString{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if(BasketActivity.tableView != nil){ BasketActivity.tableView.reloadData()
                    }
                    debugPrint(response)
                default:
                    debugPrint(response)
                }
            }
            
        }
        
    }
    
    public func remove(product:String){
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.basketRemove

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "product", value: product)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
                
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.headers = headers;
                
        URLs.session.request(request).responseString{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if(BasketActivity.tableView != nil){ BasketActivity.tableView.reloadData()
                    }
                    debugPrint(response)
                default:
                    debugPrint(response)
                }
            }
                        
        }
    }
    
}
