//
//  CreatePurchaseDialog.swift
//  mebel
//
//  Created by DS on 22.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CreatePurchaseDialog:UIViewController{

    
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var comment: UITextField!
    
    var setComment: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCancel.layer.cornerRadius = 5
        btnCancel.layer.borderWidth = 0.5
        btnCancel.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.borderWidth = 0.5
        btnSubmit.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        MenuAdapter.setBackStyle(layer: back.layer)
        
        if setComment != nil {
            _ = SetText(label: comment, value: setComment)
        }
               
    }
    
    
    @IBAction func submit(_ sender: Any) {
        self.dismiss(animated:true, completion:{
            BasketActivity.baskets = [];
            BasketWork().create(comment:self.comment.text)
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
    
}
