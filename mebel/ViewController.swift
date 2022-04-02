//
//  ViewController.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import SwiftUI
import Alamofire
import Pushy

class ViewController: UIViewController, UISearchBarDelegate{
        
    public static var typeMenu:TypeGridViewMenu = TypeGridViewMenu.MENU;
    public static var idMenu:String = "";
    
    public static var enableAdd:Bool = true
    public static var enableAddNews:Bool = true
    public static var enableAddPurchase:Bool = true
    
    public static var categories_in:[CategoryItem] = []
    public static var categories:[CategoryItem] = []
    public static var products:[ProductItem] = []
    public static var news:[NewsItem] = []
    public static var purchases:[PurchaseItem] = []
    
    public static var account:AccountObject!
        
    public static var adapterMenu:UICollectionViewController = MenuAdapter();
    public static var gridView:UICollectionView!;
        
    public static var nv:UINavigationController = UINavigationController();
    public static var sb:UIStoryboard = UIStoryboard();
    
    public static var filters:[Filter] = [];
    public static var category:String?;
    
    public static var lastSearch:String!;
    
    @IBOutlet weak var stackInfo: UIStackView!
    @IBOutlet weak var stackNews: UIStackView!
    @IBOutlet weak var stackHome: UIStackView!
    @IBOutlet weak var stackOrder: UIStackView!
    @IBOutlet weak var stackAccount: UIStackView!
    
    @IBOutlet weak var iconInfo: UIImageView!
    @IBOutlet weak var iconNews: UIImageView!
    @IBOutlet weak var iconHome: UIImageView!
    @IBOutlet weak var iconOrder: UIImageView!
    @IBOutlet weak var iconAccount: UIImageView!
    
    @IBOutlet weak var iconFilter: UIImageView!
    @IBOutlet weak var iconBasket: UIImageView!
    
    @IBOutlet weak var labelLimit: UILabel!
    @IBOutlet weak var labelDebt: UILabel!
    @IBOutlet weak var labelBasket: UILabel!
    @IBOutlet weak var labelRest: UILabel!
    
    @IBOutlet weak var bannersScrollView: UIScrollView!
    @IBOutlet weak var bannersStack: UIStackView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    public static var banners:[Banner]!
    public static var app: AppObject!
    public static var context:UIViewController!
    public static var instance: ViewController?
    
    
    public static var isIpad: Bool = false
    
    public var newNotification: NotificationObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController.context = self
        ViewController.instance = self
        
        ViewController.self.nv = self.navigationController!;
        ViewController.self.sb = self.storyboard!;
        
        searchBar.delegate = self
        
        ViewController.isIpad = UIDevice.current.userInterfaceIdiom == .pad
        
        initById()
        makeIcons()
        getApp()
        
        let authItem:AuthItem! = SL.getAuth();
        if(authItem != nil){
            _ = Login(auth: authItem);
        } else{
            pushActivity(id: "AccountLogin", myType: AccountLogin.self)
        }
        
        _ = GetMenu(id: nil, fromMenu: false)
        
        if newNotification != nil {
            if (newNotification.type.elementsEqual("URL")){
                
                let url = URL(string: newNotification.id)!
                UIApplication.shared.open(url)
                
            } else if newNotification.type.elementsEqual("NEWS"){
                
                let result = (ViewController.sb.instantiateViewController(withIdentifier: "NewsOpenActivity")) as! NewsOpenActivity as NewsOpenActivity
                result.id = newNotification.id
                ViewController.nv.pushViewController(result, animated:true)
                
            } else if newNotification.type.elementsEqual("GOOD"){
                
                let result = (ViewController.sb.instantiateViewController(withIdentifier: "ProductActivity")) as! ProductActivity as ProductActivity
                result.id = newNotification.id
                result.item = nil
                ViewController.nv.pushViewController(result, animated:true)
            }
            newNotification = nil
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 0 {
            ViewController.lastSearch = searchBar.text;
            _ = GetSearch(text: searchBar.text!, add: false)
        }
        clearSearch()
    }
    
    func clearSearch(){
        self.searchBar.text = nil
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
    }
    
    func buildBanners(){
        
        let width = bannersScrollView.layer.frame.width - 40
        let height: CGFloat = ViewController.isIpad ? 280 : 140
        
        for item in ViewController.banners {
           
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.frame = CGRect(x: 0, y: 0, width: width, height: 140)
            
            let imgView = UIImageView()
            MenuAdapter.setBackStyle(layer: imgView.layer)
            
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imgView.layer.cornerRadius = 10
            imgView.frame = CGRect(x: 0, y: 0, width: width, height: 140)
            imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: width / 140).isActive = true
            
            imgView.addTapGestureRecognizer {
                debugPrint(item.type)
                if(item.type == "URL" && item.url != nil){
                    if let url = URL(string: item.url) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:])
                        }
                    }
                } else if(item.type == "NEWS" && item.id != nil){
                    let result = (ViewController.sb.instantiateViewController(withIdentifier: "NewsOpenActivity")) as! NewsOpenActivity as NewsOpenActivity
                    result.id = item.id;
                    ViewController.nv.pushViewController(result, animated:true)
                } else if(item.type == "GOOD" && item.id != nil){
                    let result = (ViewController.sb.instantiateViewController(withIdentifier: "ProductActivity")) as! ProductActivity as ProductActivity
                    result.id = item.id;
                    ViewController.nv.pushViewController(result, animated:true)
                }
            }
            
            _ = LoadImage(img: imgView, url: item.icon)
            
            stackView.addArrangedSubview(imgView)
            bannersStack.addArrangedSubview(stackView)

        }
        
        ViewController.instance?.bannersScrollView.isHidden = false
        
    }
    
    func initById(){
        ViewController.gridView = self.view.viewWithTag(TagsView.gridViewMenu) as? UICollectionView
    }
    
    func makeIcons(){
        
        let tapInfo = UITapGestureRecognizer(target: self,
                                                action: #selector(openacontacts(_:)))
        tapInfo.numberOfTapsRequired = 1;
        stackInfo.addGestureRecognizer(tapInfo);
        stackInfo.isUserInteractionEnabled = true;

        let tapNews = UITapGestureRecognizer(target: self,
                                                action: #selector(news(_:)))
        tapNews.numberOfTapsRequired = 1;
        stackNews.addGestureRecognizer(tapNews);
        stackNews.isUserInteractionEnabled = true;
        
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(home(_:)))
        tapHome.numberOfTapsRequired = 1;
        stackHome.addGestureRecognizer(tapHome);
        stackHome.isUserInteractionEnabled = true;
        
        let tapOrder = UITapGestureRecognizer(target: self,
                                                action: #selector(purchases(_:)))
        tapOrder.numberOfTapsRequired = 1;
        stackOrder.addGestureRecognizer(tapOrder);
        stackOrder.isUserInteractionEnabled = true;
        
        let tapAccount = UITapGestureRecognizer(target: self,
                                                action: #selector(openaccaunt(_:)))
        tapAccount.numberOfTapsRequired = 1;
        stackAccount.addGestureRecognizer(tapAccount);
        stackAccount.isUserInteractionEnabled = true;
        
        let tapFilter = UITapGestureRecognizer(target: self,
                                                action: #selector(openfilter(_:)))
       
        
        
        
    }
    
    @objc func openfilter(_ sender: Any) {
        if ViewController.filters.count > 0 {
            pushActivity(id: "FiltersActivity", myType: FiltersActivity.self)
        }
    }
    
    @objc func opensearch(_ sender: Any) {
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "SearchDialog"))
            as! SearchDialog as SearchDialog
        ViewController.nv.present(result, animated: false, completion: nil)
        
    }
    
    @objc func openbasket(_ sender: Any) {
        if ViewController.account == nil {
            let result = (ViewController.sb.instantiateViewController(withIdentifier: "AccountLogin")) as! AccountLogin as AccountLogin
            ViewController.nv.pushViewController(result, animated:true)
            return
        }
        pushActivity(id: "BasketActivity", myType: BasketActivity.self)
    }
    
    @objc func openaccaunt(_ sender: Any) {
        
        CATransaction.begin()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = 1
        
        CATransaction.setCompletionBlock{
            
            if ViewController.account == nil {
                self.pushActivity(id: "AccountLogin", myType: AccountLogin.self)
            } else {
                self.pushActivity(id: "AccountActivity", myType: AccountActivity.self)
            }
            
        }
        
        self.iconAccount.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        CATransaction.commit()
    }
    
    @objc func openacontacts(_ sender: Any) {
        
        CATransaction.begin()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = 1
        
        CATransaction.setCompletionBlock{
            
            self.pushActivity(id: "AboutUsActivity", myType: AboutUsActivity.self)
        
        }
        
        self.iconInfo.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        CATransaction.commit()
    }
    
    @objc func purchases(_ sender: Any) {
        
        CATransaction.begin()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = 1
        
        CATransaction.setCompletionBlock{
            
            if(ViewController.account == nil){
                let result = (ViewController.sb.instantiateViewController(withIdentifier: "AccountLogin")) as! AccountLogin as AccountLogin
                ViewController.nv.pushViewController(result, animated:true)
                return
            }
            
            ViewController.instance?.bannersScrollView.isHidden = true
            
            if(ViewController.purchases.count > 0){
                if(ViewController.typeMenu != TypeGridViewMenu.PURCHASE){
                    ViewController.typeMenu = TypeGridViewMenu.PURCHASE
                }
                ViewController.gridView.reloadData()
            } else {
                _ = GetPurchase(add: false)
            }
        
        }
        
        self.iconOrder.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        CATransaction.commit()
        
    }
    
    @objc func home(_ sender: Any) {
        
        CATransaction.begin()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = 1
        
        CATransaction.setCompletionBlock{
            
            if((ViewController.instance?.bannersStack.subviews.count)! > 0){
                ViewController.instance?.bannersScrollView.isHidden = false
            }
            
            if(ViewController.categories.count > 0){
                if(ViewController.typeMenu != TypeGridViewMenu.MENU){
                    ViewController.typeMenu = TypeGridViewMenu.MENU;
                }
                ViewController.gridView.reloadData()
            } else {
                _ = GetMenu(id: nil, fromMenu: false)
            }
        
        }
        
        self.iconHome.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        CATransaction.commit()
    }
    
    @objc func news(_ sender: Any) {
        
        CATransaction.begin()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = 1
        
        CATransaction.setCompletionBlock{
            
            ViewController.instance?.bannersScrollView.isHidden = true
            
            if(ViewController.news.count > 0){
                if(ViewController.typeMenu != TypeGridViewMenu.NEWS){
                    ViewController.typeMenu = TypeGridViewMenu.NEWS
                }
                ViewController.gridView.reloadData()
            } else {
                _ = GetNews(add: false)
            }
        
        }
        
        self.iconNews.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        CATransaction.commit()
        
    }
    
    public static func updateLimits(){
        _ = SetText(label: (ViewController.instance?.labelLimit)!, value: ViewController.account.payment.limit, decimal: 2)
        _ = SetText(label: (ViewController.instance?.labelDebt)!, value: ViewController.account.payment.debt, decimal: 2)
        _ = SetText(label: (ViewController.instance?.labelBasket)!, value: ViewController.account.payment.inbasket, decimal: 2)
        _ = SetText(label: (ViewController.instance?.labelRest)!, value: ViewController.account.payment.rest, decimal: 2)
    }
    
    
    func pushActivity<T>(id:String, myType:T.Type){
        let result = (self.storyboard?.instantiateViewController(withIdentifier: id))! as! T as T
        self.navigationController?.pushViewController(result as! UIViewController, animated:true)
    }
    
    func presentActivity<T>(id:String, myType:T.Type){
        let result = (self.storyboard?.instantiateViewController(withIdentifier: id))! as! T as T
        self.navigationController?.present(result as! UIViewController, animated: true)
    }
    
    func getApp(){
        
        let url:String = URLs.sayt + "/" + URLs.api + "/hs/SUPPORT/INFO/"

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers:headers).response{ response in
            do {
                ViewController.app = try JSONDecoder().decode(AppObject.self, from: response.data!)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    public func getBaners(){
        
        let url:String = URLs.sayt + "/" + URLs.api + "/hs/BANNERS/LIST/"
        
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                
                switch status {
                case 200:
                    do{
                        ViewController.banners = try JSONDecoder().decode([Banner].self, from: response.data!)
                        self.buildBanners()
                    } catch { }
                default: break
                }
            }
        }
        
    }
}

