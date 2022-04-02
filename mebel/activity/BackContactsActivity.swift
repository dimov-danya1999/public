//
//  BackContactsActivity.swift
//  mebel
//
//  Created by DS on 26.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Alamofire

class BackContactsActivity: UIViewController{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var message: UITextView!
    
    @IBOutlet weak var homeIcon: UIImageView!
    
    var json:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeIcons()
        
        if(ViewController.account != nil){
            _ = SetText(label: name, value: ViewController.account!.name)
            _ = SetText(label: email, value: ViewController.account!.email)
        }
        
    }
    
    func makeIcons(){
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1;
        homeIcon.addGestureRecognizer(tapHome)
        homeIcon.isUserInteractionEnabled = true
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        MenuAdapter.setBackStyle(layer: btnSend.layer)
        btnSend.layer.cornerRadius = 5
        btnSend.layer.borderWidth = 0.5
        btnSend.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
        
    @IBAction func send(_ sender: Any) {
        
        if !(name.text!.count > 0){
            DialogMessage.info(viewController: self, message:"Введите имя!")
            return
        }
        
        if !Controller.isValidEmail(email:self.email.text!) {
            DialogMessage.info(viewController: self, message:"Проверьте E-mail!")
            return
        }
        
        if !Controller.isValidPhone(phone:self.phone.text!) {
            DialogMessage.info(viewController: self, message:"Проверьте телефон!")
            return
        }
        
        if !(message.text!.count > 0){
            DialogMessage.info(viewController: self, message:"Введите сообщение!")        }
        
        let backItem = BackContactObject();
        backItem.email = email.text!;
        backItem.phone = phone.text!;
        backItem.name = name.text!;
        backItem.message = message.text!;
        
        do{
            let jsonData = try JSONEncoder().encode(backItem)
            self.json = String(data:jsonData, encoding: String.Encoding.utf8)!
            
            debugPrint(self.json)
            
            connect()
            
        } catch {
            debugPrint(error)
        }
        
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.backContactsSend
        
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = self.json.data(using: .utf8)
        request.headers = headers
                
        URLs.session.request(request).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    DialogMessage.httpInfo(viewController: self, data: response.data!)
                    debugPrint(response)
                default:
                    DialogMessage.httpError(viewController: self, data: response.data!)
                    debugPrint(response)
                }
            }
                 
            self.finish()
        }
    }
    
    func finish(){
        ProgressBar.dismiss()
    }
    
}
