//
//  PurchaseOpenActivity.swift
//  mebel
//
//  Created by DS on 03.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Alamofire
import UIKit

class PurchaseOpenActivity:UIViewController{
        
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var number: UILabel!
        
    public static var object:PurchaseObject = PurchaseObject();
    
    public var id:String = "";
    
    public static var gridView: UICollectionView!
    public static var adapter: UICollectionViewController!
    public static var isEditable: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        makeIcons()
        initById()
        connect()
    }
    
    func makeIcons(){
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1;
        homeIcon.addGestureRecognizer(tapHome);
        homeIcon.isUserInteractionEnabled = true;
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        date.textColor = Colors.hexStringToUIColor(hex:Colors.appColor)
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    func initById(){
        PurchaseOpenActivity.gridView = self.view.viewWithTag(TagsView.gridViewPurchaseOpen) as? UICollectionView
    }
    
    func buildView(){
        self.title = PurchaseOpenActivity.object.number;
        
        _ = SetText(label: number, value: PurchaseOpenActivity.object.number)
        _ = SetText(label: date, value: PurchaseOpenActivity.object.date)
        _ = SetText(label: status, value: PurchaseOpenActivity.object.status)
        
        
        if PurchaseOpenActivity.object.status == PurchaseStatus.Sended.rawValue{
            status.textColor = Colors.hexStringToUIColor(hex: Colors.statusSended)
        } else if PurchaseOpenActivity.object.status == PurchaseStatus.Accept.rawValue{
            status.textColor = Colors.hexStringToUIColor(hex: Colors.statusAccept)
        } else if PurchaseOpenActivity.object.status == PurchaseStatus.Cancel.rawValue{
            status.textColor = Colors.hexStringToUIColor(hex: Colors.statusReject)
        } else if PurchaseOpenActivity.object.status == PurchaseStatus.Stay.rawValue{
            status.textColor = Colors.hexStringToUIColor(hex: Colors.statusInProgress)
        }
        
        PurchaseOpenActivity.isEditable = PurchaseOpenActivity.object.status.elementsEqual("Ожидает рассмотрения")
        
        PurchaseOpenActivity.adapter = PurchaseOpenListAdapter()
        PurchaseOpenActivity.gridView.delegate = PurchaseOpenActivity.adapter
        PurchaseOpenActivity.gridView.dataSource = PurchaseOpenActivity.adapter
        PurchaseOpenActivity.gridView.reloadData()
    }
    
    @IBAction func cancelpurchase(_ sender: Any) {
        cancelPurchase();
    }
        
    func connect(){
       
        ProgressBar.show()
       
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseObject;
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "id", value: id)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        

        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
           
            if let status = response.response?.statusCode {
               switch status {
               case 200:
                   do{
                    
                    PurchaseOpenActivity.object = try JSONDecoder().decode(PurchaseObject.self, from: response.data!)
                    
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
    
    func cancelPurchase(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.purchaseCancel

        var headers:HTTPHeaders = []
        headers.add(name: "id", value: PurchaseOpenActivity.object.id)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
        
        URLs.session.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            var success:Bool = false;
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    success = true;
                    _ = GetPurchase(add: false);
                default:
                    debugPrint(response)
                }
            }
            
            ProgressBar.dismiss()
            
            if(success){
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
}
