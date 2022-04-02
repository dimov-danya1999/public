//
//  GetFilters.swift
//  mebel
//
//  Created by DS on 24.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class GetFilters{
    
    var show:Bool = false;
    
    init(show:Bool){
        self.show = show;
        connect()
        
        debugPrint("get filters")
    }
    
    func connect(){
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.filtersList
        
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"id", value: ViewController.category!)
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.headers = headers;
        
        URLs.session.request(request).responseString{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    
                    do{
                        debugPrint(response)
                        ViewController.filters = try JSONDecoder().decode([Filter].self, from: response.data!)
                    } catch {
                        debugPrint(error)
                    }
                    
                    if(self.show){
                        if(ViewController.filters.count > 0){
                            debugPrint(response)
                        }
                    }
                    
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
        }
        
    }
    
}
