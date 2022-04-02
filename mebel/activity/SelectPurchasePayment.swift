//
//  SelectPurchasePayment.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import UIKit

class SelectPurchasePayment:UIViewController{
    
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var stackOnline: UIStackView!
    @IBOutlet weak var stackOnGet: UIStackView!
    @IBOutlet weak var stackCredit: UIStackView!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCancel.layer.cornerRadius = 5
        btnCancel.layer.borderWidth = 0.5
        btnCancel.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        MenuAdapter.setBackStyle(layer: back.layer)
        
        MenuAdapter.setBackStyle(layer: stackOnline.layer)
        MenuAdapter.setBackStyle(layer: stackOnGet.layer)
        MenuAdapter.setBackStyle(layer: stackCredit.layer)
        
        let tapOnline = UITapGestureRecognizer(target: self,
                                                action: #selector(setOnline(_:)))
        tapOnline.numberOfTapsRequired = 1
        stackOnline.addGestureRecognizer(tapOnline)
        stackOnline.isUserInteractionEnabled = true
        
        let tapOnGet = UITapGestureRecognizer(target: self,
                                                action: #selector(setOnGet(_:)))
        tapOnGet.numberOfTapsRequired = 1
        stackOnGet.addGestureRecognizer(tapOnGet)
        stackOnGet.isUserInteractionEnabled = true
        
        let tapCredit = UITapGestureRecognizer(target: self,
                                                action: #selector(setCredit(_:)))
        tapCredit.numberOfTapsRequired = 1
        stackCredit.addGestureRecognizer(tapCredit)
        stackCredit.isUserInteractionEnabled = true
        
    }
    
    @objc func setOnline(_ sender: Any) {
        
        self.dismiss(animated:true, completion:{
            _ = Payments(context: BasketActivity.context, sum: BasketActivity.totalSum)
        })
    }
    
    @objc func setOnGet(_ sender: Any) {
        self.dismiss(animated:true, completion:{
            let result = (ViewController.sb.instantiateViewController(withIdentifier: "CreatePurchaseDialog"))
                as! CreatePurchaseDialog as CreatePurchaseDialog
            result.setComment = "Оплата при получении"
            ViewController.nv.present(result, animated: false, completion: nil)
        })
    }
    
    @objc func setCredit(_ sender: Any) {
        self.dismiss(animated:true, completion:{
            let result = (ViewController.sb.instantiateViewController(withIdentifier: "CreatePurchaseDialog"))
                as! CreatePurchaseDialog as CreatePurchaseDialog
            result.setComment = "В рассрочку"
            ViewController.nv.present(result, animated: false, completion: nil)
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
    
}
