//
//  ProductActivity.swift
//  mebel
//
//  Created by DS on 07.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Alamofire
import UIKit
import Kingfisher

class ProductActivity: UIViewController {

    @IBOutlet weak var listChar: UIStackView!
    @IBOutlet weak var groupCharStack: UIStackView!
    @IBOutlet weak var groupRecomStrack: UIStackView!
    @IBOutlet weak var rest: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var basketIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var addStack: UIStackView!
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var priceStack: UIStackView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var valuta: UILabel!
    @IBOutlet weak var shareStack: UIStackView!
    @IBOutlet weak var shareIcon: UIImageView!
    
    var object:ProductObject = ProductObject()
    public var id:String = ""
    public var item:ProductItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        icon.layer.cornerRadius = 10;
        
        makeIcons()
        connect()
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    @objc func openBasket(_ sender: Any){
        if ViewController.account == nil {
            let result = (ViewController.sb.instantiateViewController(withIdentifier: "AccountLogin")) as! AccountLogin as AccountLogin
            ViewController.nv.pushViewController(result, animated:true)
            return
        }
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "BasketActivity")) as! BasketActivity as BasketActivity
        ViewController.nv.pushViewController(result, animated:true)
        
    }
    
    @objc func share(_ sender: Any) {
        let text = object.name + "\n" + object.description;
        let url = URLs.webSayt + "/description-" + object.id;
        let img = icon.image?.jpegData(compressionQuality: 0.9);
        let all = [text, img!, url] as [Any]
        let activityViewCon = UIActivityViewController(activityItems: all, applicationActivities: nil)
        self.navigationController?.present(activityViewCon, animated: true, completion: nil)
    }
    
    @objc func add(_ sender: Any) {
        if(ViewController.account == nil){
            let result = (ViewController.sb.instantiateViewController(withIdentifier: "AccountLogin")) as! AccountLogin as AccountLogin
            ViewController.nv.pushViewController(result, animated:true)
            return
        }
        
        let result = (self.storyboard?.instantiateViewController(withIdentifier: "AddToBasketDialog")) as! AddToBasketDialog as AddToBasketDialog
        result.product = item;
        self.navigationController?.present(result, animated: false, completion: nil)
    }
    
    func makeIcons(){
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1;
        homeIcon.addGestureRecognizer(tapHome);
        homeIcon.isUserInteractionEnabled = true;
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        let tapBasket = UITapGestureRecognizer(target: self,
                                                action: #selector(openBasket(_:)))
        tapBasket.numberOfTapsRequired = 1;
        basketIcon.addGestureRecognizer(tapBasket);
        basketIcon.isUserInteractionEnabled = true;
        basketIcon.image = basketIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        let tapShare = UITapGestureRecognizer(target: self,
                                                action: #selector(share(_:)))
        tapShare.numberOfTapsRequired = 1;
        shareStack.addGestureRecognizer(tapShare);
        shareStack.isUserInteractionEnabled = true;
        shareIcon.image = shareIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        shareIcon.tintColor = UIColor.black
        
        let tapAdd = UITapGestureRecognizer(target: self,
                                                action: #selector(add(_:)))
        tapAdd.numberOfTapsRequired = 1;
        addStack.addGestureRecognizer(tapAdd);
        addStack.isUserInteractionEnabled = true;
        
        
        name.textColor = Colors.hexStringToUIColor(hex:Colors.appColor)
        
        MenuAdapter.setBackStyle(layer: priceStack.layer)
        MenuAdapter.setBackStyle(layer: shareStack.layer)
        MenuAdapter.setBackStyle(layer: addStack.layer)
        MenuAdapter.setBackStyle(layer: icon.layer)
        
        groupCharStack.layer.cornerRadius = 1
        groupCharStack.layer.shadowColor = Colors.hexStringToUIColor(hex: Colors.appColor4).cgColor
        groupCharStack.layer.shadowOffset = CGSize(width: 3, height: 3)
        groupCharStack.layer.shadowOpacity = 0.7
        groupCharStack.layer.shadowRadius = 4.0
        groupCharStack.layer.masksToBounds = false
        
        groupRecomStrack.layer.cornerRadius = 1
        groupRecomStrack.layer.shadowColor = Colors.hexStringToUIColor(hex: Colors.appColor4).cgColor
        groupRecomStrack.layer.shadowOffset = CGSize(width: 3, height: 3)
        groupRecomStrack.layer.shadowOpacity = 0.7
        groupRecomStrack.layer.shadowRadius = 4.0
        groupRecomStrack.layer.masksToBounds = false
        
        addStack.layer.cornerRadius = 5
        addStack.layer.borderWidth = 0.5
        addStack.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
    }
    
    func buildView(){
        
        if item == nil {
            item = ProductItem()
            item.name = object.name
            item.price = object.price
            item.icon = object.icon
            item.id = object.id
            item.rest = object.rest
            item.price_opt = object.price_opt
            item.price_discont = object.price_discont
            item.discont = object.discont
            item.novelty = object.novelty
            item.choise = object.choise
        }
        
        _ = LoadImage(img: icon, url: object.icon)
        _ = SetText(label: descrip, value: object.description)
        _ = SetText(label: rest, value: object.rest, decimal: 2)
        _ = SetText(label: name, value: object.name.uppercased())
        _ = SetText(label: valuta, value: ViewController.account == nil ? "AZN" : ViewController.account.valuta.uppercased())
        _ = SetText(label: price, value: object.price, decimal: 2)
        

        for item in object.properties {
            
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            
            let labelName = UILabel()
            labelName.textColor = Colors.hexStringToUIColor(hex: Colors.appColor)
            labelName.text = item.name
            labelName.font = UIFont.boldSystemFont(ofSize: 14.0)
            stackView.addArrangedSubview(labelName)
            
            let labelValue = UILabel()
            labelValue.textColor = Colors.hexStringToUIColor(hex: Colors.colorBlack)
            labelValue.text = item.value
            labelValue.font = labelValue.font.withSize(14)
            stackView.addArrangedSubview(labelValue)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
            
            listChar.addArrangedSubview(stackView)
        }
        
    }
    
    func connect(){
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.productOpen;

        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "id", value: id)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
             if let status = response.response?.statusCode {
                
                switch status {
                case 200:
                    do{
                        self.object = try JSONDecoder().decode(ProductObject.self, from: response.data!)
                        self.buildView()
                    } catch {
                        debugPrint("---------- start error")
                        debugPrint(error)
                        DialogMessage.httpError(viewController: self, data: response.data!)
                    }
                default:
                    debugPrint(response)
                }
             }
            
             ProgressBar.dismiss()
        }
    }
}
