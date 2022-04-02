//
//  BasketActivity.swift
//  mebel
//
//  Created by DS on 06.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class BasketActivity:UIViewController{
    
    public static var context: UIViewController!
    
    public static var tableView:UITableView!
    public static var baskets:[BasketItem] = [];
    let adapter:BasketAdapter = BasketAdapter()
    
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var valuta: UILabel!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var create: UIButton!
    
    public static var totalSum: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BasketActivity.context = self
        
        initById()
        makeIcons()
        
        connect()
    }
    
    func makeIcons(){
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1;
        homeIcon.addGestureRecognizer(tapHome);
        homeIcon.isUserInteractionEnabled = true;
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        MenuAdapter.setBackStyle(layer: create.layer)
        create.layer.cornerRadius = 5
        create.layer.borderWidth = 0.5
        create.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
    }
    
    func UpdateTotal(){
        
        var basketSize: Float = 0
        var basketSum: Float = 0
        for item in BasketActivity.baskets {
            basketSize = basketSize + item.size
            basketSum = basketSum + (item.size * item.price)
        }
        
        BasketActivity.totalSum = basketSum
        
        _ = SetText(label: sum, value: basketSum, decimal: 2)
        _ = SetText(label: size, value: basketSize)
        _ = SetText(label: types, value: BasketActivity.baskets.count)
        _ = SetText(label: valuta, value: ViewController.account == nil ? "AZN" : ViewController.account.valuta.uppercased())
        
    }
    
    @IBAction func create(_ sender: Any) {
        UpdateTotal()
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "SelectPurchasePayment"))
            as! SelectPurchasePayment as SelectPurchasePayment
        ViewController.nv.present(result, animated: false, completion: nil)
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    func initById(){
        BasketActivity.tableView = (self.view.viewWithTag(TagsView.tableBasket) as! UITableView)
    }
    
    func buildView(){
        BasketActivity.tableView.delegate = self.adapter;
        BasketActivity.tableView.dataSource = self.adapter;
        BasketActivity.tableView.reloadData();
        
        UpdateTotal()
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.basketList;
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
           
            if let status = response.response?.statusCode {
               switch status {
               case 200:
                   do{
                                        
                    BasketActivity.baskets = try JSONDecoder().decode([BasketItem].self, from: response.data!)
                    
                    self.buildView()
                       
                   } catch {
                       DialogMessage.httpError(viewController: self, data: response.data!)
                   }
               default:
                   debugPrint(response)
               }
            }
            
            ProgressBar.dismiss()
        }
        
    }
    
    public static func showWebView(payData: EPOS.EposPayData, sum: Float){
        
        debugPrint("passing_init")
        
        WebViewController.payData = payData
        WebViewController.sum = sum
        
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "WebViewController")) as! WebViewController as WebViewController
        ViewController.nv.present(result, animated: true, completion: nil)
    }
    
    public static func checkPay(id:String, sum: Float){
        
        ProgressBar.show()
        
        let url:String = EPOS.getCheckUrl(id: id)
        
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
                        let infoPay:EPOS.EposInfoPay = try JSONDecoder().decode(EPOS.EposInfoPay.self, from: response.data!)
                        if (infoPay.result.lowercased() == "success"){
                            ProgressBar.dismiss()
                            BasketActivity.sendToServer(payId: infoPay.id, method: "EPOSAZ", sum: sum)
                           return
                        } else {
                            DialogMessage.show(viewController: BasketActivity.context, title: "Ошибка", message: "Ошибка платежа №" + id)
                        }
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                default:
                    debugPrint(response)
                }
            }
            ProgressBar.dismiss()
        }
        
    }
    
    private static func sendToServer(payId: String, method: String, sum: Float){
        
        ProgressBar.show()
        
        let parameters = [
            "payId" : payId,
            "method" : method,
            "sum" : sum
        ] as [String : Any]
        
        let url:String = URLs.sayt + "/" + URLs.api + "/hs/ACCOUNT/PAY/"
        
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
         
        URLs.session.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
             if let status = response.response?.statusCode {
                switch status {
                case 200:
                    let authItem:AuthItem! = SL.getAuth()
                    if(authItem != nil){
                        _ = Login(auth: authItem);
                    }
                    ProgressBar.dismiss()
                    ViewController.nv.popViewController(animated: true)
                default:
                    debugPrint(response)
                }
             }
            ProgressBar.dismiss()
        }
        
    }
    
    
    public class InfoPayServer: Codable {
        
        var payId:String
        var method:String
        var sum:Float
        
        init() {
            self.payId = ""
            self.method = ""
            self.sum = 0
        }
    }
    
}
