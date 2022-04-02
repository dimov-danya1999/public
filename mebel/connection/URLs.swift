//
//  URLs.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire

public class URLs{
    
    public static let session: Session = {
        let manager = ServerTrustManager(evaluators: ["bkuvps.smtp.az":DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    public static let base64login:String = "RmFyaXo6ZkByaXo="
    
    public static var webSayt:String = "https://myshops.az/"
    public static var sayt:String = "http://bkuvps.smtp.az:63330"
    public static var api:String = "MyShops"
    
    public static var categoriesList:String = "/hs/CATEGORIES/LIST/"
    public static var searchList:String = "/hs/CATEGORIES/SEARCH/"
    public static var categoriesChilds:String = "/hs/CATEGORIES/CHILDS/"
    
    public static var newsList:String = "/hs/NEWS/LIST/"
    public static var newsObject:String = "/hs/NEWS/OBJECT/"
    
    public static var filtersList:String = "/hs/FILTERS/LIST/"
    public static var filtersSubmit:String = "/hs/FILTERS/SUBMIT/"
    
    public static var authLogin:String = "/hs/ACCOUNT/LOGIN/"
    public static var authRegistr:String = "/hs/ACCOUNT/REGISTR/"
        
    public static var purchaseRemove:String = "/hs/PURCHASE/REMOVE/"
    public static var purchaseList:String = "/hs/PURCHASE/LIST/"
    public static var purchaseSize:String = "/hs/PURCHASE/SIZE/"
    public static var purchaseObject:String = "/hs/PURCHASE/OBJECT/"
    public static var purchaseCancel:String = "/hs/PURCHASE/CANCEL/"
    public static var purchaseCreate:String = "/hs/PURCHASE/CREATE/"
    
    public static var backContactsSend:String = "/hs/BACKCONTACT/SEND/"
    public static var aboutUsDescription:String = "/hs/ABOUTUS/DESCRIPTION/"
    public static var contactsObject:String = "/hs/CONTACTS/OBJECT/"
    
    public static var basketAdd:String = "/hs/BASKET/ADD/"
    public static var basketRemove:String = "/hs/BASKET/REMOVE/"
    public static var basketCancel:String = "/hs/BASKET/CANCEL/"
    public static var basketList:String = "/hs/BASKET/LIST/"
    
    public static var productOpen:String = "/hs/PRODUCT/OPEN/"
    
    
    public static func getStaticUserAgent() -> String{
        return "Mozilla/5.0 (Linux; Android 9.1; SM-G90120P Build/LRX221T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Mobile Safari/537.36";
    }
    
    public static func getUserAgentWindow() -> String{
        return "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36";
    }
    
    public static func getUserAgentMac() -> String{
        return "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.2 Safari/605.1.15"
    }
}
