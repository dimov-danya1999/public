//
//  Login.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire
import Pushy

class Login {
    
    var json:String = "";
    
    init(auth:AuthItem) {
        
        do{
            let jsonData = try JSONEncoder().encode(auth)
            self.json = String(data:jsonData, encoding: String.Encoding.utf8)!
                
            connect()
            
        }catch {
            debugPrint(error)
        }
    }
    
    func connect() {
        
        ProgressBar.show()
                
        let url:String = URLs.sayt + "/" + URLs.api + URLs.authLogin
        
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = self.json.data(using: .utf8)
        request.headers = headers;
                
        URLs.session.request(request).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    do{
                        ViewController.account = try JSONDecoder().decode(AccountObject.self, from: response.data!)
                        _ = GetMenu(id: nil, fromMenu: false);
                        ViewController.instance?.getBaners()
                        ViewController.updateLimits()
                        
                        let token = UserDefaults.standard.string(forKey: "pushyToken")
                        if token != nil {
                            _ = SetToken(token: token!)
                        }
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
