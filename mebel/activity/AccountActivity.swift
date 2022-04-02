//
//  AccountActivity.swift
//  mebel
//
//  Created by DS on 27.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit

class AccountActivity: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var exitIcon: UIImageView!
    @IBOutlet weak var activityIcon: UIImageView!
    @IBOutlet weak var limit: UILabel!
    @IBOutlet weak var debt: UILabel!
    @IBOutlet weak var rest: UILabel!
    @IBOutlet weak var basket: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if ViewController.account == nil {
            self.dismiss(animated: false)
            return
        }
        
        makeIcons()
        
    }
    
    
    func makeIcons(){
        
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1;
        homeIcon.addGestureRecognizer(tapHome);
        homeIcon.isUserInteractionEnabled = true;
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        let tapExit = UITapGestureRecognizer(target: self,
                                                action: #selector(exitAccount(_:)))
        tapExit.numberOfTapsRequired = 1;
        exitIcon.addGestureRecognizer(tapExit);
        exitIcon.isUserInteractionEnabled = true;
        exitIcon.image = exitIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        exitIcon.tintColor = Colors.hexStringToUIColor(hex:Colors.colorWhite)
        
        activityIcon.image = activityIcon.image?.withRenderingMode(.alwaysTemplate)
        activityIcon.tintColor = Colors.hexStringToUIColor(hex:Colors.appColor)
        
        _ = SetText(label: name, value: ViewController.account.name)
        _ = SetText(label: email, value: ViewController.account.email)
        _ = SetText(label: limit, value: ViewController.account.payment.limit, decimal: 2)
        _ = SetText(label: debt, value: ViewController.account.payment.debt, decimal: 2)
        _ = SetText(label: rest, value: ViewController.account.payment.rest, decimal: 2)
        _ = SetText(label: basket, value: ViewController.account.payment.inbasket, decimal: 2)
        
    }
    
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    
    @objc func exitAccount(_ sender: Any) {
        
        ViewController.account = nil;
        SL.deleteAuth()
        
        self.navigationController?.popViewController(animated: true)
        
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "AccountLogin")) as! AccountLogin as AccountLogin
        ViewController.nv.pushViewController(result, animated:true)
        
    }
    
}
