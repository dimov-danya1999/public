//
//  GetNews.swift
//  mebel
//
//  Created by DS on 02.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire


class GetNews{
    
    var add:Bool = false;
    
    init(add:Bool) {
        self.add = add;
        
        ViewController.typeMenu = TypeGridViewMenu.NEWS
        
        connect()
        
    }
    
    func connect(){
                
        ProgressBar.show()
                
        let url:String = URLs.sayt + "/" + URLs.api + URLs.newsList
        
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        ViewController.enableAddNews = false;
        
        if add {
            let lastItem:NewsItem = ViewController.news[ViewController.news.count - 1]
            headers.add(name: "last",value: lastItem.id)
        } else {
            ViewController.news = [];
        }
                        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    do{
                        let newItems = try JSONDecoder().decode([NewsItem].self, from: response.data!)
                        
                        ViewController.enableAddNews = newItems.count > 9
                        ViewController.news.append(contentsOf:newItems);
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
