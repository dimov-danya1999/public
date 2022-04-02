//
//  EPOS.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class EPOS{
    
    var context:UIViewController!
    var cardType:Int = 1 //0=>'Visa', 1=>'MasterCard', 2=>'Bolkart'

    var sum: Float
    //public PaymentCard paymentCard;
    
    public static let errorUrl: String = "http://pay.error/"
    public static let successUrl: String = "http://pay.success/"

    init(context:UIViewController, sum: Float) {
        self.context = context
        self.sum = sum
        selectCard()
    }

    private func selectCard(){
        
        let alert = UIAlertController(title: "Выбирете карту", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "VISA", style: .default)
        {action -> Void in
            self.cardType = 0
            self.payCreateWebView()
        })
        alert.addAction(UIAlertAction(title: "MasterCard", style: .default)
        {action -> Void in
            self.cardType = 1
            self.payCreateWebView()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default){action -> Void in})
        context.present(alert, animated: true, completion: nil)
        
    }
    
    func payCreateWebView(){
        
        ProgressBar.show()
        
        let url:String = self.getPrimaryUrl()
        
        let headers:HTTPHeaders = [
            "Referer" : "xxx",
            "Origin" : "xxx",
            "Content-Type" : "application/x-www-form-urlencoded",
            "Connection" : "keep-alive",
            "Accept-Charset" : "ISO-8859-1,utf-8;q=0.7,*;q=0.3",
            "Cache-Control" : "max-age=0",
            "Except" : "xxx",
            "User-Agent" : URLs.getUserAgentMac()
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON {response in

            if let status = response.response?.statusCode {

                switch status {
                case 200:
                    do{
                        let payData:EposPayData = try JSONDecoder().decode(EposPayData.self, from: response.data!)
                        self.showWebView(payData: payData)

                    } catch {
                        debugPrint("error_1" + error.localizedDescription)
                    }
                default:
                    debugPrint(response)
                }
            }
            ProgressBar.dismiss()
        }
        
    }
    
    private func showWebView(payData:EposPayData){
        
        BasketActivity.showWebView(payData: payData, sum: sum)
    
    }
    
    public static func getCheckUrl(id:String) -> String{
        
        let params = [
            "id" : id,
            "key" : ViewController.app.eposPrivateKey
        ]
        
        let paramsSorted = params.sorted(by: { $0.0 < $1.0 })
        
        var sum : String = ""
        for(_, value) in paramsSorted {
            sum = sum + value
        }
        sum = sum + ViewController.app.eposPrivateKey
        sum = EPOS.MD5(input: sum, radix: 16)
        
        var url : String = "";
        for(kay, value) in paramsSorted{
            url = url + "&" + kay + "=" + value
        }
        url = "https://epos.az/api/pay2me/status/?" + url.dropFirst() + "&sum=" + sum
        
        return url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
    }
    
    private func getPrimaryUrl() -> String{
        
        let phone: String  = "994701111111";
        
        let params = [
            "amount" : String(format: "%.2f", sum),
            "cardType" : String(cardType),
            "description" : "",
            "email" : "",
            "errorUrl" : EPOS.errorUrl,
            "key" : ViewController.app.eposPablickKey,
            "phone" : phone,
            "payFormType" : "MOBILE", //DESKTOP MOBILE
            "successUrl" : EPOS.successUrl,
            "taksit" : "0",
            "currency" : ViewController.account.valuta.elementsEqual("AZN") ? "AZN" : "USD"
        ]
        
        let paramsSorted = params.sorted(by: { $0.0 < $1.0 })

        var sum : String = ""
        for(_, value) in paramsSorted {
            sum = sum + value
        }
        sum = sum + ViewController.app.eposPrivateKey
        sum = EPOS.MD5(input: sum, radix: 16)

        var url : String = "";
        for(kay, value) in paramsSorted{
            url = url + "&" + kay + "=" + value
        }
        
        url = "https://epos.az/api/pay2me/pay/?" + url.dropFirst() + "&sum=" + sum

        return url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    }
    
    public static func MD5(input: String, radix: Int) -> String{
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = input.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    
    public class EposPayData: Codable {
        
        var result:String
        var paymentUrl:String
        var id:String
        
        init() {
            self.result = ""
            self.paymentUrl = ""
            self.id = ""
        }
    }
    
    class EposErrorData: Codable {
        
        var error:String
        var errorCode:Int
        var errorMessage:String
        
        init() {
            self.error = ""
            self.errorCode = 0
            self.errorMessage = ""
        }
    }
    
    class EposRedirectData: Codable {
        
        var redirect:String
        var info:String
        var errorCode:Int
        
        init() {
            self.redirect = ""
            self.errorCode = 0
            self.info = ""
        }
    }
    
    class EposSuccessData: Codable {
        
        var result:String
        var paymentUrl:String
        var id:String
        
        init() {
            self.result = ""
            self.paymentUrl = ""
            self.id = ""
        }
    }
    
    public class EposInfoPay: Codable {
        
        var result:String
        var info:String
        var status:Int
        var cardnumber:String
        var id:String
        
        init() {
            self.result = ""
            self.info = ""
            self.status = 0
            self.cardnumber = ""
            self.id = ""
        }
    }
    
}

