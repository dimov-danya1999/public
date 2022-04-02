//
//  ContactsActivity.swift
//  mebel
//
//  Created by DS on 26.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Alamofire

class ContactsActivity : UIViewController{
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var groupContacts: UIStackView!
    @IBOutlet weak var groupTime: UIStackView!
    @IBOutlet weak var groupSocial: UIStackView!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var mapIcon: UIImageView!
    
    var object:ContactObject = ContactObject();
    
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
        
        let tapMap = UITapGestureRecognizer(target: self,
                                                action: #selector(openMap(_:)))
        tapMap.numberOfTapsRequired = 1;
        mapIcon.addGestureRecognizer(tapMap)
        mapIcon.isUserInteractionEnabled = true
        mapIcon.image = mapIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
    }
    
    func builView(){
        
        _ = SetText(label: adress, value: object.adress)
        _ = SetText(label: activityName, value: object.name)
        
        for item in object.work_time {
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            
            let labelName = UILabel()
            labelName.textColor = Colors.hexStringToUIColor(hex: Colors.appColor)
            labelName.text = item.day
            labelName.textAlignment = .left
            labelName.font = UIFont.boldSystemFont(ofSize: 14.0)
            stackView.addArrangedSubview(labelName)
            
            let labelValue = UILabel()
            labelValue.textColor = Colors.hexStringToUIColor(hex: Colors.colorBlack)
            labelValue.textAlignment = .right
            labelValue.text = item.start + "-" + item.end
            labelValue.font = labelValue.font.withSize(14)
            stackView.addArrangedSubview(labelValue)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
            
            groupTime.addArrangedSubview(stackView)
        }
         
        for item in object.contacts {
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            
            let labelName = UILabel()
            labelName.textColor = Colors.hexStringToUIColor(hex: Colors.appColor)
            labelName.text = item.name
            labelName.textAlignment = .left
            labelName.font = UIFont.boldSystemFont(ofSize: 14.0)
            stackView.addArrangedSubview(labelName)
            
            let labelValue = UILabel()
            labelValue.textColor = Colors.hexStringToUIColor(hex: Colors.colorBlack)
            labelValue.textAlignment = .right
            labelValue.text = item.value
            labelValue.font = labelValue.font.withSize(14)
            stackView.addArrangedSubview(labelValue)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
            
            groupContacts.addArrangedSubview(stackView)
        }
        
    }
    
    @objc func openMap(_ sender: Any) {
        
        let url = URL(string: self.object.map)!
        UIApplication.shared.open(url)
        
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    func connect(){
        
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.contactsObject
                
        var headers:HTTPHeaders = []
        headers.add(name:"Accept-Language", value: "*")
        headers.add(name:"Authorization", value: "Basic " + URLs.base64login)
        
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers:headers).responseJSON{ response in
        
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    debugPrint("succes")
                default:
                    debugPrint(response)
                    return
                }
            }
            
            do{
                self.object = try JSONDecoder().decode(ContactObject.self, from: response.data!)
                self.builView()
            } catch {
                debugPrint(error)
            }
            
            ProgressBar.dismiss()
            
        }
    }
}
