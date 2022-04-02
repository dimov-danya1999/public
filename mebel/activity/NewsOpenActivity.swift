//
//  NewsOpenActivity.swift
//  mebel
//
//  Created by DS on 01.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Alamofire
import Kingfisher
import UIKit

class NewsOpenActivity: UIViewController {

    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var opisanie: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var statia: UIStackView!
    
    var object:NewsObject = NewsObject();
    
    public var id:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        date.textColor = Colors.hexStringToUIColor(hex:Colors.appColor)
    }
    
    func buildView(){
        _ = SetText(label: date, value: object.date)
        _ = SetText(label: head, value: object.head)
        _ = LoadImage(img: icon, url: object.icon)
        
        let width = self.statia.frame.width
        
        for item in object.description {
            if(item.type.elementsEqual("TEXT")){
                
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
                label.numberOfLines = 0
                label.textAlignment = .justified
                label.textColor = Colors.hexStringToUIColor(hex:Colors.colorBlack)
                _ = SetText(label: label, value: item.value + "\n")
                self.statia.addArrangedSubview(label)
                
            } else if (item.type.elementsEqual("IMAGE")){
                
                let height:CGFloat = ViewController.isIpad ? 360 : 180
                
                let imgView = UIImageView()
                MenuAdapter.setBackStyle(layer: imgView.layer)
                imgView.contentMode = .scaleAspectFill
                imgView.clipsToBounds = true
                imgView.layer.cornerRadius = 10
                imgView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: width / height).isActive = true
                _ = LoadImage(img: imgView, url: item.value)
                self.statia.addArrangedSubview(imgView)
                
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
                label.numberOfLines = 1
                label.textAlignment = .justified
                _ = SetText(label: label, value: " ")
                self.statia.addArrangedSubview(label)
                
            }
            
        }
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    func connect(){
       
        ProgressBar.show()
       
        let url:String = URLs.sayt + "/" + URLs.api + URLs.newsObject;
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "id", value: id)
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        
        URLs.session.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
           
            if let status = response.response?.statusCode {
               switch status {
               case 200:
                   do{
                    
                    self.object = try JSONDecoder().decode(NewsObject.self, from: response.data!)
                    
                    self.buildView()
                       
                   } catch {
                       debugPrint(String(decoding: response.data!, as: UTF8.self))
                   }
               default:
                   debugPrint(response)
               }
            }
            
            ProgressBar.dismiss()
        }

    }
    
}
