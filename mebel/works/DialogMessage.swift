//
//  DialogMessage.swift
//  mebel
//
//  Created by DS on 29.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit

class DialogMessage{
    
    public static func httpError(viewController:UIViewController, data:Data){
        let message = String(decoding: data, as: UTF8.self)
        let alert = getNewAlert(title:"Ошибка", message:message)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    public static func httpInfo(viewController:UIViewController, data:Data){
        let message = String(decoding: data, as: UTF8.self)
        let alert = getNewAlert(title:"Информация", message:message)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    public static func infoTopData(data:Data){
        let message = String(decoding: data, as: UTF8.self)
        let alert = getNewAlert(title:"Информация", message:message)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    public static func infoTop(message:String){
        let alert = getNewAlert(title: "Информация", message: message)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    public static func info(viewController:UIViewController, message:String){
        let alert = getNewAlert(title: "Информация", message: message)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public static func show(viewController:UIViewController, title: String, message: String){
        let alert = getNewAlert(title: title, message: message)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private static func getNewAlert(title:String, message:String) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    }
    
    
    
    
}
