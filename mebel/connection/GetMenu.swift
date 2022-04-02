//
//  GetMenu.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

class GetMenu{
    
    var id:String?;
    var fromMenu:Bool = false;
    
    init(id:String?, fromMenu:Bool) {
        
        self.id = id;
        self.fromMenu = fromMenu;
        
        ViewController.category = id;
        
        if(self.id == TypeGridViewMenu.DISCONT.rawValue
            || self.id == TypeGridViewMenu.NOVELTY.rawValue
            || self.id == TypeGridViewMenu.CHOISE.rawValue){
            ViewController.idMenu = self.id!;
            ViewController.categories_in = [];
            _ = GetCategory(add: false)
            return
        }
        
        ViewController.gridView.delegate = ViewController.adapterMenu
        ViewController.gridView.dataSource = ViewController.adapterMenu
        
        if(fromMenu){
            ViewController.typeMenu = TypeGridViewMenu.MENU_IN
        } else {
            ViewController.typeMenu = TypeGridViewMenu.MENU
        }
        
        connect()
    }
       
    
    private func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.categoriesList
        
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        
        if id != nil{
            headers.add(name: "id",value: id!)
        }
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                
                switch status {
                case 200:
                    do{
                        let newCategories = try JSONDecoder().decode([CategoryItem].self, from: response.data!)
                        if(self.fromMenu){
                            ViewController.categories_in = newCategories;
                            
                        } else {
                            ViewController.categories = newCategories;
                        }
                    } catch {
                        DialogMessage.httpError(viewController: ViewController.context, data: response.data!)
                    }
                case 201:
                    do{
                        let newProducts = try JSONDecoder().decode([ProductItem].self, from: response.data!)
                        
                        ViewController.categories_in = [];
                        ViewController.products = [];
                        
                        ViewController.products.append(contentsOf: newProducts)
                        
                        ViewController.typeMenu = TypeGridViewMenu.CATEGORY;
                        
                    } catch {
                        ViewController.typeMenu = TypeGridViewMenu.MENU;
                        
                        DialogMessage.httpError(viewController: ViewController.context, data: response.data!)
                    }
                default:
                    DialogMessage.httpError(viewController: ViewController.context, data: response.data!)
                    return
                }
            }
            NotificationCenter.default.post(name: Notification.Name("changeBack"), object: nil)
            
            ViewController.gridView.reloadData();
                        
            ProgressBar.dismiss()
            
        }
        
        
    }
    
}
