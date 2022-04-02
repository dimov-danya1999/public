//
//  AccountRegistr.swift
//  mebel
//
//  Created by DS on 29.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Alamofire

class AccountRegistr: UIViewController {

    
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    
    @IBOutlet weak var btnRegistr: UIButton!
    @IBOutlet weak var btnAuth: UIButton!
    
    var json:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegistr.layer.cornerRadius = 5;
        btnAuth.layer.cornerRadius = 5;
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
        
    }
    
    @IBAction func registr(_ sender: Any) {
        
        if !(lastname.text!.count > 0){
            DialogMessage.info(viewController: self, message:"Введите фамилию!")
            return
        }
        
        if !(name.text!.count > 0){
            DialogMessage.info(viewController: self, message:"Введите имя!")
            return
        }
        
        if !(firstname.text!.count > 0){
            DialogMessage.info(viewController: self, message:"Введите отчество!")
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
        
        let pas1 = password1.text;
        let pas2 = password2.text;
        if pas1 != pas2 {
            DialogMessage.info(viewController: self, message:"Пароли не совпадают!")
            return
        }
        
        let acc:AccountRegistrObject = AccountRegistrObject();
        acc.email = email.text!;
        acc.name = name.text!;
        acc.phone = phone.text!;
        acc.lastname = lastname.text!;
        acc.firstname = firstname.text!;
        acc.password = pas1!;
        
        let components = date.calendar.dateComponents([.day, .month, .year], from: date.date)
        acc.date = components.day!;
        acc.month = components.month!;
        acc.year = components.year!;
        
        do{
            let jsonData = try JSONEncoder().encode(acc)
            self.json = String(data:jsonData, encoding: String.Encoding.utf8)!
                
            connect()
            
        } catch {
            debugPrint(error)
        }
        
    }
        
    @IBAction func auth(_ sender: Any) {
        weak var pvc = self.presentingViewController;
        self.dismiss(animated:true, completion:{
            let result = (self.storyboard?.instantiateViewController(withIdentifier: "AccountLogin"))! as! AccountLogin as AccountLogin
            pvc?.present(result, animated:true, completion:nil)
        })
    }
    
    func connect() {
        
        ProgressBar.show()
                
        let url:String = URLs.sayt + "/" + URLs.api + URLs.authRegistr
        
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
                    debugPrint("succes")
                    do{
                        
                        ViewController.account =  try JSONDecoder().decode(AccountObject.self, from: response.data!)
                        
                        SL.saveAuth(email: self.email.text!, password: self.password1.text!)
                        
                        ProgressBar.dismiss()
                                        
                        self.dismiss(animated:true, completion:nil)
                       
                    } catch {
                        DialogMessage.httpError(viewController: self, data: response.data!)
                    }
                default:
                    DialogMessage.httpError(viewController: self, data: response.data!)
                }
            }
            
            ProgressBar.dismiss()
        }
        
    }
    

}
