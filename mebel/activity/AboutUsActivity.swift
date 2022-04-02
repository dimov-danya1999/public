//
//  AboutUsActivity.swift
//  mebel
//
//  Created by DS on 26.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Alamofire

class AboutUsActivity: UIViewController {
        
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var backStack: UIStackView!
    @IBOutlet weak var contIcon: UIImageView!
    @IBOutlet weak var contStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        makeIcons()
        connect()
    }
    
    func makeIcons(){
        
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1;
        homeIcon.addGestureRecognizer(tapHome)
        homeIcon.isUserInteractionEnabled = true
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        MenuAdapter.setBackStyle(layer: backStack.layer)
        backStack.layer.cornerRadius = 5
        backStack.layer.borderWidth = 0.5
        backStack.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        MenuAdapter.setBackStyle(layer: contStack.layer)
        contStack.layer.cornerRadius = 5
        contStack.layer.borderWidth = 0.5
        contStack.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        let tapContact = UITapGestureRecognizer(target: self,
                                                action: #selector(contacts(_:)))
        tapContact.numberOfTapsRequired = 1;
        contStack.addGestureRecognizer(tapContact)
        contStack.isUserInteractionEnabled = true
        contIcon.image = contIcon.image?.withAlignmentRectInsets(Paddings.minus10)
        
        
        let tapBack = UITapGestureRecognizer(target: self,
                                                action: #selector(backContacts(_:)))
        tapBack.numberOfTapsRequired = 1;
        backStack.addGestureRecognizer(tapBack)
        backStack.isUserInteractionEnabled = true
        backIcon.image = contIcon.image?.withAlignmentRectInsets(Paddings.minus10)
        
        
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    @objc func contacts(_ sender: Any) {
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "ContactsActivity")) as! ContactsActivity as ContactsActivity
        ViewController.nv.pushViewController(result, animated:true)
    }
    
    @objc func backContacts(_ sender: Any) {
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "BackContactsActivity")) as! BackContactsActivity as BackContactsActivity
        ViewController.nv.pushViewController(result, animated:true)
    }
    
    func connect(){
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.aboutUsDescription
                
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers:headers).response{ response in
            do {
                let text = String(data: response.data!, encoding: .utf8)
                _ = SetText(label: self.descript, value: text!.htmlToString)
            } catch {
                debugPrint(error)
            }
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
